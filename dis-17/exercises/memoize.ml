(** [hard_work ()] takes a long time to compute the value 5. *)
let hard_work () =
  Unix.sleep 1;
  5

(** [memoize f] is a memoized version of [f] that mutably saves computed results. *)
let memoize (f: 'a -> 'b): ('a -> 'b) =
  failwith "Unimplemented"

(** [memoize_rec factorial n] is [n!]. *)
let factorial self n =
  if n = 0 then 1 else n * (self (n - 1))

(** [memoize_rec fibonacci n] is the [n]th Fibonacci number. *)
let fibonacci self n =
  if n <= 1 then 1 else (self (n - 1)) + (self (n - 2))

(** [memoize_rec f] is a memoized version of recursive function [f]. *)
let memoize_rec (f: 'a -> 'b): ('a -> 'b) =
  failwith "Unimplemented"
