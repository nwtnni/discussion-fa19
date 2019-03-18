type 'a linked_list = {
  mutable root: 'a node option;
}

and 'a node = {
  elem: 'a;
  mutable next: 'a node option;
}

(* Q: Why does this have to take in unit?
 * What happens if we remove the unit argument? *)
let empty () =
  { root = None }

let push (e: 'a) (l: 'a linked_list) : unit =
  let root' = { elem = e; next = l.root } in
  l.root <- Some root'

let pop (l: 'a linked_list) : 'a option =
  match l.root with
  | None -> None
  | Some node -> l.root <- node.next; Some node.elem

let len (l: 'a linked_list) : int =
  let rec len' (node: 'a node) =
    match node.next with
    | None       -> 1
    | Some node' -> 1 + len' node'
  in
  match l.root with
  | None      -> 0
  | Some node -> len' node
