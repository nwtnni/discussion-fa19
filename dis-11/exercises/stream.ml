(* Take One *)
(* type t = int * t *)

(* Take Two *)
type t = {
  head: int;
  tail: t;
}

let head s = s.head

let tail s = s.tail

let rec make (n : int) : t =
  { head = n;
    tail = make (n + 1) }

(* Take Three *)
type t = {
  head: int;
  tail: unit -> t;
}

let head s = s.head

let tail s =
  failwith "Unimplemented"

let rec make (n: int) : t =
  failwith "Unimplemented"

(* Take Four *)
type t =
| Stream of int * (unit -> t)

let head s =
  failwith "Unimplemented"

let tail s =
  failwith "Unimplemented"

let make (n: int) =
  failwith "Unimplemented"
