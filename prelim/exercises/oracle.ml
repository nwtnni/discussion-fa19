module type Oracle = sig

  type t

  type direction =
  | Left
  | Middle
  | Right
  | Stop

  val next: t -> t -> direction

end

module type Tree = sig

  type key

  type t

  val empty: t

  val insert: key -> t -> t

  val mem: key -> t -> bool

end

module Make (O: Oracle) : Tree with type key = O.t = struct

  type key = O.t

  type t =
  | Leaf
  | Node of {
    k: key;
    l: t;
    m: t;
    r: t;
  }

  let empty =
    failwith "Unimplemented"

  let rec insert k tree =
    failwith "Unimplemented"

  let rec mem k tree =
    failwith "Unimplemented"

end
