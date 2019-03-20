open Lwt.Infix

type rx = Lwt_io.input Lwt_io.channel
type tx = Lwt_io.output Lwt_io.channel

type client = {
  addr: Unix.sockaddr;
  name: string; 
}

let clients: (client * tx) list ref = ref []

let get_client (addr: Unix.sockaddr) : (client * tx) option =
  List.find_opt (fun (client, _) -> client.addr = addr) !clients

let get_others (addr: Unix.sockaddr) : (client * tx) list =
  List.filter (fun (client, _) -> client.addr <> addr) !clients

let insert_client (cl: client) (oc: tx) =
  clients := (cl, oc) :: !clients

let remove_client (addr: Unix.sockaddr): (client * tx) option =
  let client = get_client addr in
  let clients' = get_others addr in
  clients := clients';
  client

let rec create_socket () =
  let sock = Lwt_unix.socket Lwt_unix.PF_INET Lwt_unix.SOCK_STREAM 0 in
  let addr = Lwt_unix.ADDR_INET (Unix.inet_addr_any, 10000) in
  Lwt_unix.bind sock addr
  >|= begin fun () -> Lwt_unix.listen sock 100 end
  >|= begin fun () -> sock end

and loop socket =
  Lwt_unix.accept socket >>= accept >>= fun () -> loop socket

and accept (file, addr) =
  let ic = Lwt_io.of_fd Lwt_io.Input file in
  let oc = Lwt_io.of_fd Lwt_io.Output file in
  Lwt.async (fun () -> initialize addr ic oc);
  Lwt.return ()

and initialize addr ic oc =
  Lwt_io.write_line oc "Welcome to lwt-chatroom! Please enter a nickname."
  >>= fun () -> register addr ic oc
  
and register addr ic oc =
  Lwt_io.read_line_opt ic >>= function
  | None -> disconnect addr
  | Some name -> connect addr name oc >>= fun () -> listen addr ic

and listen addr ic = 
  Lwt_io.read_line_opt ic >>= function
  | None -> disconnect addr
  | Some command -> parse addr command >>= fun () -> listen addr ic

and parse addr command =
  let ws = Str.regexp "[ ]+" in
  match Str.bounded_split ws command 2 with
  | ["q"]       | ["quit"]       -> disconnect addr
  | ["n"; name] | ["nick"; name] -> change addr name
  | _                            -> send_but addr command

and connect addr name oc =
  insert_client { addr; name } oc;
  let join = Printf.sprintf "%s has joined the chat." name in
  send_all join

and disconnect addr =
  match remove_client addr with
  | None -> Lwt.return ()
  | Some (client, _) ->
    let left = Printf.sprintf "%s has left the chat." client.name in
    send_all left

and change addr name' =
  match remove_client addr with
  | None -> Lwt.return ()
  | Some (client, oc) ->
    insert_client { client with name = name' } oc;
    let name = Printf.sprintf "%s has changed their name to %s." client.name name' in
    send_all name

and send_all message =
  send !clients (fmt_time message)

and send_but addr message =
  match get_client addr with
  | None -> disconnect addr
  | Some (client, _) ->
    message |> fmt_name client
            |> fmt_time
            |> send (get_others addr)

and send clients message =
  clients |> List.map snd
          |> List.map (Lwt_io.write_line)
          |> List.map (fun write -> write message)
          |> Lwt.join

and fmt_name client message =
  Printf.sprintf
    "%s: %s" 
    client.name
    message

and fmt_time message =
  let time = Unix.gettimeofday () |> Unix.localtime in
  Printf.sprintf
    "[%i/%i/%i %i:%i:%i] %s"
    (time.tm_mon + 1)
    time.tm_mday
    (time.tm_year mod 100)
    time.tm_hour
    time.tm_min
    time.tm_sec
    message

let () =
  Lwt_main.run (create_socket () >>= loop)
