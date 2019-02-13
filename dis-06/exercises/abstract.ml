module type Nonzero = sig
  type t

  (** [t_of_int n] is [Some v] if [n] is non-zero, and [None] otherwise. *)
  val t_of_int: int -> t option

  (** [int_of_t v] is the int representation of [v]. *)
  val int_of_t: t -> int
end

module NonzeroSealed : Nonzero = struct
  type t = int

  let t_of_int = function
  | 0 -> None
  | n -> Some n

  let int_of_t n = n
end

module NonzeroFree = struct
  type t = int

  let t_of_int = function
  | 0 -> None
  | n -> Some n

  let int_of_t n = n
end
