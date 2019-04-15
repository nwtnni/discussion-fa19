open Ast
open Parser
open Lexer

(* Environment binding variable names to values *)
type env = (var * int) list

(** Big-step expression interpreter *)
let rec eval_exp (env: env) (e: exp) : int =
  match e with
  | Int i -> i
  | Var v -> List.assoc v env
  | Bin (b, l, r) -> (eval_bin b) (eval_exp env l) (eval_exp env r)

and eval_bin (b: bin) : (int -> int -> int) =
  match b with
  | Add -> ( + )
  | Sub -> ( - )
  | Mul -> ( * )
  | Div -> ( / )

(** Big-step statement interpreter *)
let rec eval_stm (env: env) (s: stm) : env =
  match s with
  | Let (v, e) ->
    (v, eval_exp env e) :: env
  | Seq (s1, s2) ->
    eval_stm (eval_stm env s1) s2
  | Print e ->
    print_int (eval_exp env e);
    print_newline ();
    env
  | If (e, t, None) ->
    let _ = if eval_exp env e = 1 then
      eval_stm env s |> ignore
    else
      ()
    in
    env
  | If (e, t, Some f) ->
    let _ = if eval_exp env e = 1 then
      eval_stm env s
    else
      eval_stm env f
    in
    env

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
