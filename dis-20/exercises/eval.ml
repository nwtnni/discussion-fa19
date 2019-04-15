open Ast
open Parser
open Lexer

(* Environment binding variable names to values *)
type env = (var * value) list

(* Typing context binding variable names to types *)
type context = (var * typ) list

let rec eval_int_bop = function
  | Add -> (+)
  | Sub -> (-)
  | Mul -> ( * )
  | Div -> (/)
  | _ -> failwith "Type error in integer bop"

let rec eval_bool_bop = function
  | And -> (&&)
  | Or  -> (||)
  | _ -> failwith "Type error in boolean bop"

(** Big-step expression interpreter *)
let rec eval_exp (env: env) (e: exp) : value =
  match e with
  | Val v -> v
  | Var s -> List.assoc s env
  | Bin (bop, e1, e2) -> 
    let v1 = eval_exp env e1 in 
    let v2 = eval_exp env e2 in 
    match v1, v2 with
    | Int i1, Int i2 -> Int (eval_int_bop bop i1 i2)
    | Bool b1, Bool b2 -> Bool (eval_bool_bop bop b1 b2)
    | _ -> failwith "Type error in eval_binop"


(** Big-step statement interpreter *)
let rec eval_stm (env: env) (s: stm) : env =
  failwith "Unimplemented"

let rec check_exp (c: context) (e: exp) : typ =
  failwith "Unimplemented"

let rec check_stm (c: context) (s: stm) : typ =
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
