type 'a linked_list = {
  mutable root: 'a node option;
}

and 'a node = {
  elem: 'a;
  mutable next: 'a node option;
}

let empty () =
  failwith "Unimplemented"

let push (e: 'a) (l: 'a linked_list) : unit =
  failwith "Unimplemented"

let pop (l: 'a linked_list) : 'a option =
  failwith "Unimplemented"

let len (l: 'a linked_list) : int =
  failwith "Unimplemented"
