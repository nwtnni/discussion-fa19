open Ast

let rec of_exp = function
  | Val v -> of_val v
  | Var x -> x
  | Bin (b, l, r) ->
    Format.sprintf
      "@[(%s@ %s@ %s)@]"
      (of_exp l)
      (of_bin b)
      (of_exp r)

and of_val = function
  | Int i -> string_of_int i
  | Bool b -> string_of_bool b

and of_bin = function
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
  | And -> "and"
  | Or  -> "or"

and of_stm = function
  | Let (x, e) ->
    Format.sprintf
      "@[let %s =@ %s@]"
      x
      (of_exp e)
  | Seq (l, r) ->
    Format.sprintf
      "@[<v 0>%s@,%s@]"
      (of_stm l)
      (of_stm r)
  | Print e ->
    Format.sprintf
      "print %s"
      (of_exp e)
  | If (b, t, None) ->
    Format.sprintf
      "@[if@ %s@ {@ %s@ }@]"
      (of_exp b)
      (of_stm t)
  | If (b, t, Some f) ->
    Format.sprintf
      "@[if@ %s@ {@ %s } else {@ %s }@]"
      (of_exp b)
      (of_stm t)
      (of_stm f)
