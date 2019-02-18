(** Represents a type with a equality relation. *)
module type Equatable = sig

  (** The type of equatable values. *)
  type t

  (** [eq a b] is [true] if [a = b] else [false]. *)
  val eq: t -> t -> bool

end

module Int = struct
  type t = int

  let eq a b =
    a = b
end

module IntSealed: Equatable = struct
  type t = int
  let eq a b =
    a = b
end

module IntConstrained: Equatable with type t = int = struct
  type t = int
  let eq a b =
    a = b
end

module Human = struct
  type t = {
    id: int;
    name: string;
  }

  let eq a b =
    a.id = b.id
end
