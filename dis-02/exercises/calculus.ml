(** [constant c] is the function [f(x) = c] *)
let constant (c: float) (x: float) =
  c

(** [linear m b] is the function [f(x) = mx + b] *)
let linear (m: float) (b: float) (x: float) =
  failwith "Unimplemented"

(** [add f g] is the function [h(x) = f(x) + g(x)] *)
let add (f: float -> float) (g: float -> float) =
  fun x -> f x +. g x

(** [mul f g] is the function [h(x) = f(x) * g(x)] *)
let mul (f: float -> float) (g: float -> float) =
  failwith "Unimplemented"

(** [derivative f] is the function [g(x) = d/dx f(x)]
 *
 *  For our purposes, we define the derivative [d/dx f(x)] as:
 * 
 *    [f(x + 0.00005) - f(x - 0.00005)] / 0.00010
 *)
let derivative (f: float -> float) =
  failwith "Unimplemented"

(** [evaluate f lo hi step] prints points in the form [x,f(x)]
 *  from [lo] to [hi] in increments of [step].
 *)
let rec evaluate (f: float -> float) (lo: float) (hi: float) (step: float) =
  if lo >= hi then
    () (* Done recursing *)
  else begin
    Printf.printf "%f,%f\n" lo (f lo);
    evaluate f (lo +. step) hi step
  end

(* Example *)

(* f(x) = 3x^2 + 2x + 1 *)
let f =

  (* f(x) = x *)
  let x = linear 1. 0. in

  (* 3x^2 *)
  let x2 = mul (constant 3.) (mul x x) in

  (* 2x *)
  let x1 = mul (constant 2.) x in

  (* 1 *)
  let x0 = constant 1. in

  add (add x2 x1) x0

(* g(x) = d/dx f(x) *)
let g = derivative f

(* Main entrypoint *)
let () =
  evaluate (constant 3.0) 0.0 5.0 0.1
