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
  let v = seed in
  let l = fun () -> make (left seed) left right in
  let r = fun () -> make (right seed) left right in
  Tree (v, l, r)

(** [value tree] is the value at the current node of [tree]. *)
let value (tree: 'a t) : 'a =
  match tree with
  | Tree (v, _, _) -> v

(** [left tree] is the left subtree of [tree]. *)
let left (tree: 'a t) : 'a t =
  match tree with
  | Tree (_, l, _) -> l ()

(** [right tree] is the right subtree of [tree]. *)
let right (tree: 'a t) : 'a t =
  match tree with
  | Tree (_, _, r) -> r ()

(* CHALLENGE QUESTIONS *)

(** [map tree f] is the tree with [f x] for all nodes with value [x] in [tree]. *)
let rec map (tree: 'a t) (f: 'a -> 'b) : 'b t =
  let v = f (value tree) in
  let l = fun () -> map (left tree) f in
  let r = fun () -> map (right tree) f in
  Tree (v, l, r)

type 'a finite =
| Leaf
| Node of 'a * 'a finite * 'a finite

(** [take tree depth] is the finite subtree of depth [depth] from infinite tree [tree]. *)
let rec take (tree: 'a t) (depth: int) : 'a finite =
  if depth = 0 then
    Leaf
  else
    let v = value tree in
    let l = take (left tree) (depth - 1) in
    let r = take (right tree) (depth - 1) in
    Node (v, l, r)
