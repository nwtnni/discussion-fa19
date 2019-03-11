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
    Leaf

  let rec insert k tree =
    match tree with
    | Leaf ->
      Node { k; l = Leaf; m = Leaf; r = Leaf }
    | Node { k = k'; l; m; r } ->
      match O.next k k' with
      | Left   -> Node { k = k'; l = insert k l; m; r }
      | Middle -> Node { k = k'; l; m = insert k m; r }
      | Right  -> Node { k = k'; l; m; r = insert k r }
      | Stop   -> Node { k; l; m; r }

  let rec mem k tree =
    match tree with
    | Leaf -> false
    | Node { k = k'; l; m; r } ->
      match O.next k k' with
      | Left   -> mem k l
      | Middle -> mem k m
      | Right  -> mem k r
      | Stop   -> true

end
