(** Represents a binary operator. *)
type bin =
| Add
| Sub
| Mul
| Div

(** Represents an expression. *)
type exp =
| Int of int
| Bin of exp * bin * exp

(** [string_of_bin b] is the [string] representation of binary operator [b]. *)
let string_of_bin (b: bin) : string =
  match b with
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"

(** [string_of_exp e] is the [string] representation of expression [e]. *)
let rec string_of_exp (e: exp) : string =
  match e with
  | Int n          -> string_of_int n
  | Bin (l, op, r) ->
    let ls = string_of_exp l in
    let ops = string_of_bin op in
    let rs = string_of_exp r in
    "(" ^ ls ^ " " ^ ops ^ " " ^ rs ^ ")"

(** [eval e] is [Some n] if [e] evaluates to [n],
  *  or [None] if a division by zero occurred.  *)
let rec eval (e: exp) : (int option) =
  match e with
  | Int n -> Some n
  | Bin (l, op, r) ->
    match eval l, eval r with
    | Some l, Some r -> eval_safe l op r
    | _              -> None

and eval_safe (l: int) (op: bin) (r: int) : int option =
  match op with
  | Add -> Some (l + r)
  | Sub -> Some (l - r)
  | Mul -> Some (l * r)
  | Div when r = 0 -> None
  | Div -> Some (l / r)
