(** Represents variables. *)
type var = string

(** Represents expressions that evaluate to a value. *)
type exp =
  | Val of value
  | Var of var
  | Bin of bin * exp * exp

(** Represents values that cannot be evaluated further *)
and value =
  | Int of int
  | Bool of bool

(** Represents binary operators. *)
and bin =
  | Add
  | Sub
  | Mul
  | Div
  | And
  | Or

(** Represents statements that don't evaluate to a value. *)
and stm =
  | Let of var * exp
  | Seq of stm * stm
  | Print of exp
  | If of exp * stm * stm option

type typ =
  | TInt
  | TBool
