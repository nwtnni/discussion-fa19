(** Non tail recursive [sum] *)
let rec sum (l: int list) : int =
  match l with
  | []     -> 0         (** Base case *)
  | h :: t -> h + sum t (** Recursive case: function of current element [h] and sub-result [sum t] *)

(* What does the execution of [sum [1; 2; 3; 4; 5]] look like?
 * - [sum [1; 2; 3; 4; 5]]
 * - [1 + sum [2; 3; 4; 5]]
 * - [1 + 2 + sum [3; 4; 5]]
 * - [1 + 2 + 3 + sum [4; 5]]
 * - [1 + 2 + 3 + 4 + sum [5]]
 * - [1 + 2 + 3 + 4 + 5 + sum []]
 * - [1 + 2 + 3 + 4 + 5 + 0]
 *)

(* A: Expanding linearly *)

(** Tail recursive version of [sum] *)
let rec sum_tail (acc: int) (l: int list) : int =
  match l with
  | []     -> acc                  (** Base case *)
  | h :: t -> sum_tail (acc + h) t (** Recursive case: function of accumulator [acc] and current element [h] *)

(* What does the execution of [sum_tail 0 [1; 2; 3; 4; 5]] look like? 
 * - [sum_tail 0 [1; 2; 3; 4; 5]]
 * - [sum_tail 1 [2; 3; 4; 5]]
 * - [sum_tail 3 [3; 4; 5]]
 * - [sum_tail 6 [4; 5]]
 * - [sum_tail 10 [5]]
 * - [sum_tail 15 []]
 * - [15]
 *)

(* A: Constant size: iterative *)

(* Actual List Module Definitions *)

(* Not tail-recursive: will take multiple stack frames *)
let rec fold_right (f : 'a -> 'b -> 'b) (l : 'a list) (acc : 'b) : 'b =
  match l with
  | []      -> acc
  | x :: xs -> f x (fold_right f xs acc)

(* Tail-recursive with accumulator: iterative in nature and will take constant stack space *)
let rec fold_left (f : 'a -> 'b ->'a) (acc : 'a) (l : 'b list): 'a =
  match l with
  | []      -> acc
  | x :: xs -> fold_left f (f acc x) xs
