(** Implement a recursive factorial function without the [rec] keyword!  *)
let factorial n =
  let f: ((int -> int) ref) =
    ref (failwith "Unimplemented")
  in
  let factorial' n =
    failwith "Unimplemented"
  in
  f := failwith "Unimplemented";
  factorial' f

(* Using the same pattern of `tying the recursive knot`,
 * implement [fibonacci] without the [rec] keyword. *)
let fibonacci n =
  failwith "Unimplemented"
