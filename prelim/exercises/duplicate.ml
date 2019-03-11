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

  type v

  val insert: v -> 'a t -> 'a t

  val size: 'a t -> int

  val fold_left: ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a

  val to_list: 'a t -> 'a list

end

module Make (V: Compare) : Tree with type v = V.t = struct

  type v = V.t

  type 'a t =
  | Leaf
  | Node of
    { (* Value at this node *)
      v: 'a;
      (* Count of value at this node. Must be >= 1. *)
      n: int;
      (* Left subtree. *)
      l: 'a t;
      (* Right subtree. *)
      r: 'a t; }

  let insert tree v =
    failwith "Unimplemented"

  let size tree =
    failwith "Unimplemented"

  (* Hint: there are two cases per Node, depending on the count *)
  let fold_left f acc tree =
    failwith "Unimplemented"

  (* Implement with fold_left! *)
  let to_list tree =
    failwith "Unimplemented"

end
