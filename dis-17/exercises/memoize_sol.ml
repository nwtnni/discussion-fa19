(** [hard_work ()] takes a long time to compute the value 5. *)
let hard_work () =
  Unix.sleep 1;
  5

(** [memoize f] is a memoized version of [f] that mutably saves computed results. *)
let memoize (f: 'a -> 'b): ('a -> 'b) =
  let cache = Hashtbl.create 10 in
  fun x -> match Hashtbl.find_opt cache x with
  | None -> let y = f x in Hashtbl.add cache x y; y
  | Some y -> y

(** [factorial factorial n] is [n!]. *)
let factorial self n =
  if n = 0 then 1 else n * (self (n - 1))

(** [fibonacci fibonacci n] is the [n]th Fibonacci number. *)
let fibonacci self n =
  if n <= 1 then 1 else (self (n - 1)) + (self (n - 2))

(** [memoize_rec f] is a memoized version of recursive function [f]. *)
let memoize_rec f =
  let cache = Hashtbl.create 10 in
  let rec g x =
    match Hashtbl.find_opt cache x with
    | None -> let y = f g x in Hashtbl.add cache x y; y
    | Some y -> y
  in
  g

let () = print_int ((memoize_rec fibonacci) 50)
