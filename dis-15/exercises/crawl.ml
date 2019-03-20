open Lwt.Infix

(** Global mutable state: position of marker *)
let position = ref 0

(** Maximum distance of the marker from the left *)
let max_position = 80

(** [move_int n] shifts the marker by [n] steps.
  * Ensures [position] is in the range [0, max_position] afterward. *)
let move_int (n: int) : unit =
  position := !position + n;
  position := max !position 0;
  position := min !position max_position

(** [move_string input] attempts to parse [input] to an int [n] and then move the marker [n] steps.
  * Ensures [position] is within the range [0, max_position] afterward. *)
let move_string (input: string) : unit =
  match int_of_string_opt input with
  | Some steps -> move_int steps
  | None -> ()

(** [print ()] prints the string representation of the marker's position. *)
let print () : (unit Lwt.t) =
  let line = (String.make !position ' ') ^ "~" in
  Lwt_io.printl line

(** [handle_timer ()] waits 0.1 seconds before moving the marker 1 step to the right. *)
let handle_timer () =
  Lwt_unix.sleep 0.1 >|= begin fun () -> move_int 1 end

(** [handle_input ()] waits for the user to input some number of steps [n]
  * and moves the marker by that many steps. *)
let handle_input () =
  Lwt_io.read_line Lwt_io.stdin >|= move_string

(** [loop ()] repeatedly waits for either the timer or user input and prints the current state. *)
let rec loop () =
  Lwt.choose [handle_timer (); handle_input ()] >>= print >>= loop

(** Main entrypoint. *)
let () =
  Lwt_main.run (loop ())
