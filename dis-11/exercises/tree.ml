(** Represents an infinite binary tree. *)
type 'a t =
| Tree of ('a * (unit -> 'a t) * (unit -> 'a t))

(** [make seed left right] is the following infinite binary tree:
  *
  *                    --------------------- seed ---------------------
  *                   /                                                \
  *          --- left seed ---                                 --- right seed ---
  *         /                 \                               /                  \
  * left (left seed)    right (left seed)            left (right seed)    right (right seed)
  * /              \   /                \            /               \   /                  \
  * ...             ...                 ...        ...                ...                   ...
  *
  *)
let rec make (seed: 'a) (left: 'a -> 'a) (right: 'a -> 'a) =
  failwith "Unimplemented"

(** [value tree] is the value at the current node of [tree]. *)
let value (tree: 'a t) : 'a =
  failwith "Unimplemented"

(** [left tree] is the left subtree of [tree]. *)
let left (tree: 'a t) : 'a t =
  failwith "Unimplemented"

(** [right tree] is the right subtree of [tree]. *)
let right (tree: 'a t) : 'a t =
  failwith "Unimplemented"

(* CHALLENGE QUESTIONS *)

(** [map tree f] is the tree with [f x] for all nodes with value [x] in [tree]. *)
let rec map (tree: 'a t) (f: 'a -> 'b) : 'b t =
  failwith "Unimplemented"

type 'a finite =
| Leaf
| Node of 'a * 'a finite * 'a finite

(** [take tree depth] is the finite subtree of depth [depth] from infinite tree [tree]. *)
let rec take (tree: 'a t) (depth: int) : 'a finite =
  failwith "Unimplemented"
