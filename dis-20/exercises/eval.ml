open Ast
open Parser
open Lexer

(* Environment binding variable names to values *)
type env = (var * int) list

(** Big-step expression interpreter *)
let rec eval_exp (env: env) (e: exp) : int =
  failwith "Unimplemented"

(** Big-step statement interpreter *)
let rec eval_stm (env: env) (s: stm) : env =
  failwith "Unimplemented"

let rec main () =
  let input = read_line () in
  let lexbuf = match Sys.file_exists input with
  | true -> input |> open_in |> Lexing.from_channel 
  | false -> input |> Lexing.from_string
  in
  let program = Parser.prog Lexer.token lexbuf in
  Pretty.of_stm program |> print_endline;
  let _ = eval_stm [] program in
  main ()

let () = main ()
