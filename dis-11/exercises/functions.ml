type 'a stream =
| Stream of 'a * (unit -> 'a stream)

(** [make seed next] is the stream returning elements
  * [seed], [next seed], [next (next seed)], ... *)
let rec make (seed: 'a) (next: 'a -> 'a) : ('a stream) =
  failwith "Unimplemented"

(** [head s] is the value of the current stream. *)
let head (s: 'a stream) : 'a =
  failwith "Unimplemented"

(** [tail s] is the next stream iteration after [s]. *)
let tail (s: 'a stream) : 'a stream =
  failwith "Unimplemented"

(** [take s n] is the list of the first [n] elements of stream [s]. *)
let rec take (s: 'a stream) (n: int) : 'a list =
  failwith "Unimplemented"

(** [map s f] is the stream returning [f x] for each [x] in stream [s]. *)
let rec map (s: 'a stream) (f: 'a -> 'b) : 'b stream =
  failwith "Unimplemented"

(** EXTRA CHALLENGE QUESTIONS **)

(** [filter s f] is the stream of elements [x] of stream [s] such that [f x = true]. *)
let rec filter (s: 'a stream) (f: 'a -> bool) : 'a stream =
  failwith "Unimplemented"

(** [take_until s until] is the list of all elements of stream [s]
  * up to but not including the first element [x] where [until x = true] *)
let rec take_until (s: 'a stream) (until: 'a -> bool) : 'a list =
  failwith "Unimplemented"

(** [zip sa sb] is the stream returning [(a, b)] for each element [a] in [sa]
  * and each element [b] in [sb]. *)
let rec zip (sa: 'a stream) (sb: 'b stream) : ('a * 'b) stream =
  failwith "Unimplemented"

(** [unzip s] is the pair of streams [(sa, sb)] returning [a] and [b],
  *  respectively, for each [(a, b)] in [s]. *)
let rec unzip (s: ('a * 'b) stream) : 'a stream * 'b stream =
  failwith "Unimplemented"

(** [prepend s x] is the stream returning [x] before each element in stream [s]. *)
let prepend (s: 'a stream) (x: 'a) : 'a stream =
  failwith "Unimplemented"

(** [prepend_all s l] is the stream returning each element in list [l] before
  * returning elements in stream [s]. *)
let rec prepend_all (s: 'a stream) (l: 'a list) : 'a stream =
  failwith "Unimplemented"
