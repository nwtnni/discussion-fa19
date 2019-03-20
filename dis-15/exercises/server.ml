open Lwt.Infix

let (>>|) (opt: 'a option) (map: 'a -> 'b) : 'b option =
  match opt with
  | None -> None
  | Some a -> Some (map a)

type rx = Lwt_io.input Lwt_io.channel
type tx = Lwt_io.output Lwt_io.channel

type client = {
  addr: Unix.sockaddr;
  name: string; 
}

let clients: (client * tx) list ref = ref []

let get_client (addr: Unix.sockaddr) : client option =
  List.find_opt (fun (client, _) -> client.addr = addr) !clients >>| fst

let get_others (addr: Unix.sockaddr) : (client * tx) list =
  List.filter (fun (client, _) -> client.addr <> addr) !clients

let insert_client (cl: client) (oc: tx) =
  clients := (cl, oc) :: !clients

let remove_client (addr: Unix.sockaddr): string option =
  let client = get_client addr >>| fun client -> client.name in
  let clients' = get_others addr in
  clients := clients';
  client

let rec create_socket () =
  let sock = Lwt_unix.socket Lwt_unix.PF_INET Lwt_unix.SOCK_STREAM 0 in
  let addr = Lwt_unix.ADDR_INET (Unix.inet_addr_loopback, 10000) in
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
  Lwt_io.write_line oc "Please enter a nickname.\n"
  >>= fun () -> register addr ic oc
  
and register addr ic oc =
  Lwt_io.read_line_opt ic >>= function
  | None -> disconnect addr
  | Some name -> connect addr name oc >>= fun () -> listen addr ic

and listen addr ic = 
  Lwt_io.read_line_opt ic >>= function
  | None -> disconnect addr
  | Some message -> send_all addr message >>= fun () -> listen addr ic

and connect addr name oc =
  insert_client { addr; name } oc;
  let join = Printf.sprintf "%s has joined the chat.\n" name in
  send_all addr join

and disconnect addr =
  match remove_client addr with
  | None -> Lwt.return ()
  | Some name ->
    let left = Printf.sprintf "%s has left the chat.\n" name in
    send_all addr left

and send_all addr message =
  match get_client addr with
  | None -> disconnect addr
  | Some client ->
    let message' = Printf.sprintf "[%s]: %s" client.name message in
    addr |> get_others
         |> List.map snd
         |> List.map (send message')
         |> Lwt.join

and send message oc =
  Lwt_io.write_line oc message

let () =
  Lwt_main.run (create_socket () >>= loop)
