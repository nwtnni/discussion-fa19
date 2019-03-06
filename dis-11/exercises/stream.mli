type t

(* Create stream that goes from start to infinity *)
val make: int -> t

(* Get current value *)
val head: t -> int

(* Go to next iteration *)
val tail: t -> t
