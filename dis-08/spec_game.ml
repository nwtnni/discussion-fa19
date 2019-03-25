(** [sqr x] is the square root of [x]. 
    Requires: x is nonnegative, and a perfect square *)
val sqr : int -> int

(** [reverse lst] is [lst] with its elements reversed
    duplicates are kept in same order. *)
val reverse : 'a list -> 'a list


(** [sort lst] is [lst] with elements sorted in ascending order
    Uses quick sort algorithm (not stable) *)
val sort: int list -> int list

(** removes element at index from list 
    Raises: OutOfBoundsException if index is greater than length of list
            or negative*)
val remove: int -> 'a list -> 'a list