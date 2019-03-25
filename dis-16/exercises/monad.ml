module type Monad = sig
    type 'a t
    val return: 'a -> 'a t
    val (>>=): 'a t -> ('a -> 'b t) -> 'b t
end

module Optional = struct
    type 'a t = 'a option
    let return a = failwith "Unimplemented"
    let (>>=) a f = failwith "Unimplemented"
end

(** Try doing the following in UTOP: 
List.find_opt (fun x -> x = 5) [5;1] >>= (fun x -> return x)
*)

module Error = struct
    type 'a t = Error | Val of 'a
    let return a = failwith "Unimplemented"
    let (>>=) a f = failwith "Unimplemented"
end

module Lazy = struct
    type 'a t = unit -> 'a
    let return a = failwith "Unimplemented"
    let (>>=) a f = failwith "Unimplemented"

    (** An extra function specific to Lazy
        [force l] forces the computation on l,
        immediately evaluating it to a value *)
    let force (l: 'a t): 'a = failwith "Unimplemented" 
end

module NonDeterministic = struct
    type 'a t = 'a list
    let return a = failwith "Unimplemented"
    let (>>=) a f = failwith "Unimplemented"
end
