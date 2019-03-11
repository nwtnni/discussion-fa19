module type Compare = sig
  type t

  type ord =
  | Lt
  | Eq
  | Gt

  val compare: t -> t -> ord
end

module type Tree = sig

  type 'a t

  type key

  val insert: key -> 'a -> 'a t -> 'a t

  val size: 'a t -> int

  val fold_left: ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a

  val to_list: 'a t -> 'a list

end

module Make (K: Compare) : Tree with type key = K.t = struct

  type key = K.t

  type 'a t =
  | Leaf
  | Node of
    { (* Key at this node *)
      k: key;
      (* Value at this node *)
      v: 'a;
      (* Count of value at this node. Must be >= 1. *)
      n: int;
      (* Left subtree. *)
      l: 'a t;
      (* Right subtree. *)
      r: 'a t; }

  let rec insert k v tree =
    match tree with
    | Leaf ->
      Node { k; v; n = 1; l = Leaf; r = Leaf; } 
    | Node { k = k'; v = v'; n; l; r } ->
      match K.compare k k' with
      | Lt -> Node { k = k'; v = v'; n; l = insert k v l; r }
      | Eq -> Node { k; v; n = n + 1; l; r }
      | Gt -> Node { k = k'; v = v'; n; l; r = insert k v r }

  let rec size tree =
    match tree with
    | Leaf -> 0
    | Node { k = _; v = _; n; l; r } ->
      n + size l + size r

  let rec fold_left f acc tree =
    match tree with
    | Leaf -> acc
    | Node { k = _; v; n = 0; l; r } ->
      let left = fold_left f acc l in
      let right = fold_left f left r in
      right
    | Node { k; v; n; l; r } ->
      let here = f acc v in
      fold_left f here (Node { k; v; n = n - 1; l; r })

  let to_list tree =
    fold_left (fun l v -> v :: l) [] tree

end
