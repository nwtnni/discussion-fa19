open Lwt.Infix

type rx = Lwt_io.input Lwt_io.channel
type tx = Lwt_io.output Lwt_io.channel

type client = {
  addr: Unix.sockaddr;
  name: string;
}

(** Global list of connected clients. *)
let clients: (client * tx) list ref = ref []

(** Return the connected client with [addr], if they exist. *)
let get_client addr =
  List.find_opt (fun (client, _) -> client.addr = addr) !clients

(** Return all connected clients other than those with [addr]. *)
let get_others (addr: Unix.sockaddr) : (client * tx) list =
  List.filter (fun (client, _) -> client.addr <> addr) !clients

(** Insert the client into the connected list. *)
let insert_client (cl: client) (oc: tx) =
  clients := (cl, oc) :: !clients

(** Remove and return the client from the connected list. *)
let remove_client (addr: Unix.sockaddr): (client * tx) option =
  let client = get_client addr in
  let clients' = get_others addr in
  clients := clients';
  client

(** Continously accept new client connections. *)
let rec loop socket =
  Lwt_unix.accept socket >>= accept >>= fun () -> loop socket

(** Accept a new client connection and spawn a listening thread. *)
and accept (file, addr) =
  let ic = Lwt_io.of_fd Lwt_io.Input file in
  let oc = Lwt_io.of_fd Lwt_io.Output file in
  Lwt.async (fun () -> initialize addr ic oc);
  Lwt.return ()

(** Send a welcome message to the client and wait for name registration. *)
and initialize addr ic oc =
  Lwt_io.write_line oc "Welcome to lwt-chatroom! Please enter a nickname."
  >>= fun () -> register addr ic oc

(** Register the client with the received name. *)
and register addr ic oc =
  Lwt_io.read_line_opt ic >>= function
  | None -> disconnect addr
  | Some name -> connect addr name oc >>= fun () -> listen addr ic

(** Continuously listen for new commands on the channel. *)
and listen addr ic =
  Lwt_io.read_line_opt ic >>= function
  | None -> disconnect addr
  | Some command -> parse addr command >>= fun () -> listen addr ic

(** Parse and execute [command]. *)
and parse addr command =
  let ws = Str.regexp "[ ]+" in
  match Str.bounded_split ws command 2 with
  | ["q"]       | ["quit"]       -> disconnect addr
  | ["n"; name] | ["nick"; name] -> change addr name
  | _ -> broadcast_client addr command

(** Insert the client into the connected list and notify the room. *)
and connect addr name oc =
  insert_client { addr; name } oc;
  let join = Printf.sprintf "%s has joined the chat." name in
  broadcast_server join

(** Remove the client from the connected list and notify the room. *)
and disconnect addr =
  match remove_client addr with
  | None -> Lwt.return ()
  | Some (client, _) ->
    let left = Printf.sprintf "%s has left the chat." client.name in
    broadcast_server left

(** Change the client's nickname and notify the room. *)
and change addr name' =
  match remove_client addr with
  | None -> Lwt.return ()
  | Some (client, oc) ->
    insert_client { client with name = name' } oc;
    let name = Printf.sprintf "%s has changed their name to %s." client.name name' in
    broadcast_server name

(** Broadcast a message from the server. *)
and broadcast_server message =
  message |> fmt_time
          |> broadcast

(** Broadcast a message from a client. *)
and broadcast_client addr message =
  match get_client addr with
  | None -> Lwt.return ()
  | Some (client, _) ->
    message |> fmt_name client
            |> fmt_time
            |> broadcast

(** Broadcast a message to all connected clients. *)
and broadcast message =
  !clients |> List.map snd
           |> List.map (Lwt_io.write_line)
           |> List.map (fun write -> write message)
           |> Lwt.join

(** Prepend the client's name to [message]. *)
and fmt_name client message =
  Printf.sprintf
    "%s: %s"
    client.name
    message

(** Prepend the current time to [message]. *)
and fmt_time message =
  let time = Unix.gettimeofday () |> Unix.localtime in
  Printf.sprintf
    "[%02i/%02i/%02i %02i:%02i:%02i] %s"
    (time.tm_mon + 1)
    time.tm_mday
    (time.tm_year mod 100)
    time.tm_hour
    time.tm_min
    time.tm_sec
    message

(** Main entrypoint. Bind socket to server and loop over new connections. *)
let () =
  let port = 10000 in
  let sock = Lwt_unix.socket Lwt_unix.PF_INET Lwt_unix.SOCK_STREAM 0 in
  let addr = Lwt_unix.ADDR_INET (Unix.inet_addr_any, port) in
  Lwt_main.run begin
    Lwt_unix.bind sock addr
    >|= (fun () -> Lwt_unix.listen sock 100)
    >>= (fun () -> loop sock)
  end
