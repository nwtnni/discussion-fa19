(* Regular Types *)

let f x =
  x ^ x

let f z =
  let x = z in
  x + x

let f x y z =
  if x then y + z else z

let f x =
  fun y -> x + y

let f g =
  (g ()) + 2

let f g =
  g (g 5) 

let f g h =
  (g (h 10)) + (g 10)

let f ocaml is great =
  (ocaml is) + (ocaml great) + is + great

(* Polymorphic Types *)

let f g =
  g 5 

let f g x =
  g (g x)

let f x =
  fun y -> x

let f b x y =
  if b then x else y

let f g h =
  fun x -> g (h x)

let f g =
  fun x y -> g y x
