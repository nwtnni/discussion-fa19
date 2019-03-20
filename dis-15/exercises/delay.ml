open Lwt.Infix

(** An example of composing promises sequentially. *)
let sequential =
      fun () -> Lwt_io.printl "Starting [sequential]..."
  >>= fun () -> Lwt_unix.sleep 1.0
  >>= fun () -> Lwt_io.printl "Woke up after 1.0 seconds"
  >>= fun () -> Lwt_unix.sleep 2.0
  >>= fun () -> Lwt_io.printl "Woke up after 2.0 seconds"
  >>= fun () -> Lwt_unix.sleep 3.0
  >>= fun () -> Lwt_io.printl "Woke up after 3.0 seconds"
  >>= fun () -> Lwt_io.printl "Done!"

(** An example of composing promises concurrently. *)
let concurrent () =
  let a = Lwt_io.printl "Starting [concurrent]..." in
  let b = Lwt_unix.sleep 1.0 >>= fun () -> Lwt_io.printl "Woke up after 1.0 seconds" in
  let c = Lwt_unix.sleep 2.0 >>= fun () -> Lwt_io.printl "Woke up after 2.0 seconds" in
  let d = Lwt_unix.sleep 3.0 >>= fun () -> Lwt_io.printl "Woke up after 3.0 seconds" in
  let e = Lwt_io.printl "Done!" in
  a >>= fun () -> b
    >>= fun () -> c
    >>= fun () -> d
    >>= fun () -> e

(** Executing multiple promises concurrently with [Lwt.join]. *)
let concurrent_join () =
  let a = Lwt_io.printl "Starting [concurrent]..." in
  let b = Lwt_unix.sleep 1.0 >>= fun () -> Lwt_io.printl "Woke up after 1.0 seconds" in
  let c = Lwt_unix.sleep 2.0 >>= fun () -> Lwt_io.printl "Woke up after 2.0 seconds" in
  let d = Lwt_unix.sleep 3.0 >>= fun () -> Lwt_io.printl "Woke up after 3.0 seconds" in
  let e = Lwt_io.printl "Done!" in
  Lwt.join [a; b; c; d; e]

(** Racing promises with [Lwt.choose]. *)
let concurrent_choose () =
  let a = Lwt_unix.sleep (Random.float 1.0) >>= fun () -> Lwt_io.printl "Thread A won!" in
  let b = Lwt_unix.sleep (Random.float 1.0) >>= fun () -> Lwt_io.printl "Thread B won!" in
  Lwt.choose [a; b]
