type 'a stream =
| Stream of 'a * (unit -> 'a stream)

(** [make seed next] is the stream returning elements
  * [seed], [next seed], [next (next seed)], ... *)
let rec make (seed: 'a) (next: 'a -> 'a) : ('a stream) =
  let h = seed in
  let t = fun () -> make (next seed) next in
  Stream (h, t)

(** [head s] is the value of the current stream. *)
let head (s: 'a stream) : 'a =
  match s with
  | Stream (h, _) -> h

(** [tail s] is the next stream iteration after [s]. *)
let tail (s: 'a stream) : 'a stream =
  match s with
  | Stream (_, t) -> t ()

(** [take s n] is the list of the first [n] elements of stream [s]. *)
let rec take (s: 'a stream) (n: int) : 'a list =
  if n = 0 then [] else head s :: take (tail s) (n - 1)

(** [map s f] is the stream returning [f x] for each [x] in stream [s]. *)
let rec map (s: 'a stream) (f: 'a -> 'b) : 'b stream =
  let h = f (head s) in
  let t = fun () -> map (tail s) f in
  Stream (h, t) 

(** EXTRA CHALLENGE QUESTIONS **)

(** [filter s f] is the stream of elements [x] of stream [s] such that [f x = true]. *)
let rec filter (s: 'a stream) (f: 'a -> bool) : 'a stream =
  let h = f (head s) in
  if f h then
    let t = fun () -> filter (tail s) f in
    Stream (h, t)
  else
    filter (tail s) f

(** [take_until s until] is the list of all elements of stream [s]
  * up to but not including the first element [x] where [until x = true] *)
let rec take_until (s: 'a stream) (until: 'a -> bool) : 'a list =
  if until (head s) then
    []
  else
    head s :: take_until (tail s) until

(** [zip sa sb] is the stream returning [(a, b)] for each element [a] in [sa]
  * and each element [b] in [sb]. *)
let rec zip (sa: 'a stream) (sb: 'b stream) : ('a * 'b) stream =
  let h = (head sa, head sb) in
  let t = fun () -> zip (tail sa) (tail sb) in
  Stream (h, t)

(** [unzip s] is the pair of streams [(sa, sb)] returning [a] and [b],
  *  respectively, for each [(a, b)] in [s]. *)
let rec unzip (s: ('a * 'b) stream) : 'a stream * 'b stream =
  let (ha, hb) = head s in
  let (ta', tb') = unzip (tail s) in
  let ta = fun () -> ta' in
  let tb = fun () -> tb' in
  (Stream (ha, ta), Stream (hb, tb))

(** [prepend s x] is the stream returning [x] before each element in stream [s]. *)
let prepend (s: 'a stream) (x: 'a) : 'a stream =
  let h = x in
  let t = fun () -> s in
  Stream (h, t)

(** [prepend_all s l] is the stream returning each element in list [l] before
  * returning elements in stream [s]. *)
let rec prepend_all (s: 'a stream) (l: 'a list) : 'a stream =
  match l with
  | []      -> s
  | x :: xs ->
    let h = x in
    let t = fun () -> prepend_all s xs in
    Stream (h, t)
