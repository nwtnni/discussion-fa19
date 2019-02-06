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
let rec string_of_bin (b: bin) : string =
  failwith "Unimplemented"

(** [string_of_exp e] is the [string] representation of expression [e]. *)
let rec string_of_exp (e: exp) : string =
  failwith "Unimplemented"

(** [eval e] is [Some n] if [e] evaluates to [n],
  *  or [None] if a division by zero occurred.  *)
let rec eval (e: exp) : (int option) =
  failwith "Unimplemented"
