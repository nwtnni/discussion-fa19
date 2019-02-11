(* Manual Mapping*)

(** [increment_all l] increments every integer in list [l] by one.
 * For example:
 * - [increment_all []] is [[]]
 * - [increment_all [1; 2; 3]] is [[2; 3; 4]]
 *
 * Do NOT use [List.map] to implement this function.
 *)
let rec increment_all (l: int list) : int list =
  match l with
  | []     -> []
  | h :: t -> (h + 1) :: (increment_all t)

(** [stringify_all] converts every integer in list [l] to a string.
 * For example:
 * - [stringify_all []] is [[]]
 * - [stringify_all [1; 2; 3]] is [["1"; "2"; "3"]]
 *
 * Do NOT use [List.map] to implement this function.
 *)
let rec stringify_all (l: int list) : string list =
  match l with
  | []     -> []
  | h :: t -> (string_of_int h) :: (stringify_all t)

(* Simplifiyng with List.Map *)

(** [increment_all_map l] is equivalent to [increment_all l].
 * Implement this function with a single call to [List.map]. *)
let increment_all_map (l: int list) : int list =
  List.map (fun x -> x + 1) l

(** [stringify_all_map l] is equivalent to [stringify_all l].
 * Implement this function with a single call to [List.map]. *)
let stringify_all_map (l: int list) : string list =
  List.map string_of_int l

(* Manual Folding *)

(** [product l] is the product of all integers in list [l], or 1 if the list is empty.
 * For example:
 * - [product []] is [1]
 * - [product [10; 10; 5]] is [500]
 *
 * Do NOT use [List.fold_left] or [List.fold_right]
 *)
let rec product (l: int list) : int =
  match l with
  | []     -> 1
  | h :: t -> h * product t

(** [concatenate l] is the in-order concatenation of all strings in list [l].
 * For example:
 * - [concatenate []] is [""]
 * - [concatenate ["a"; "b"; "c"]] is ["abc"]
 *)
let rec concatenate (l: string list) : string =
  match l with
  | []     -> ""
  | h :: t -> h ^ concatenate t

(* Simplifying with [List.fold_left] *)

(** [product_fold l] is equivalent to [product l]. 
 * Implement this function with a single call to [List.fold_left]. *)
let product_fold (l: int list) : int =
  List.fold_left ( * ) 1 l

(** [concatenate_fold l] is equivalent to [concatenate l].
 * Implement this function with a single call to [List.fold_left]. *)
let concatenate_fold (l: string list) : string =
  List.fold_left (^) "" l

(* Tying it all together with pipelines *)

(** [cat_inc_products l] does the following:
 *
 * 1) Increment each element in each integer sublist by 1
 * 2) Convert each sublist into the product of its elements
 * 3) Turn each product into a string
 * 4) Concatenate all strings together
 *
 * For example, [cat_inc_products [[1]; [2; 3]; []]] goes through the following steps:
 * 
 * 1) [[[2]; [3; 4]; []]]
 * 2) [[2; 12; 1]]
 * 3) [["2"; "12"; "1"]]
 * 4) ["2121"]
 *
 * Implement this function with pipelining (|>).
 *)
let cat_inc_products (l: int list list) : string =
  l |> List.map increment_all
    |> List.map product
    |> stringify_all
    |> concatenate
