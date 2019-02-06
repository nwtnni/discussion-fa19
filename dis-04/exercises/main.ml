open Calculator

(** Prints the string representation of expression [e]. *)
let print_exp (e: exp) : exp =
  e |> string_of_exp
    |> print_endline;
  e

(** Prints the string representation of value [v]. *)
let print_value (v: int option) : unit =
  match v with
  | Some n -> n |> string_of_int |> print_endline 
  | None   -> print_endline "NaN"

(** Main user interaction *)
let rec loop () =
  try print_string "> "
  |> flush_all
  |> read_line
  |> Lexing.from_string
  |> Parser.exp Lexer.token
  |> print_exp
  |> eval
  |> print_value
  with 
  Parsing.Parse_error -> "Invalid expression."
  |> print_endline 
  |> loop

let () = loop ()
