(** Implement a recursive factorial function without the [rec] keyword!  *)
let factorial n =
  let f: ((int -> int) ref) =
    ref (fun _ -> 0)
  in
  let factorial' n =
    if n = 0 then 1 else n * !f (n - 1)
  in
  f := factorial';
  factorial' n

(* Using the same pattern of `tying the recursive knot`,
 * implement [fibonacci] without the [rec] keyword. *)
let fibonacci =
  let f = ref (fun _ -> 0) in
  let fibonacci' n =
    if n <= 1 then 1 else !f (n - 1) + !f (n - 2)
  in
  f := fibonacci';
  fibonacci'
