module type Monad = sig
    type 'a t
    val return: 'a -> 'a t
    val (>>=): 'a t -> ('a -> 'b t) -> 'b t
end

module Optional = struct
    type 'a t = 'a option
    let return a = Some a
    let (>>=) a f = 
      match a with
      | Some a -> f a
      | None -> None
end

(** Try doing the following in UTOP: 
List.find_opt (fun x -> x = 5) [5;1] >>= (fun x -> return x)
*)

module Error = struct
    type 'a t = Error of string | Val of 'a
    let return a = Val a
    let (>>=) a f = 
      match a with
      | Val a -> f a 
      | Error s -> print_endline; Error s
end

module Lazy = struct
    type 'a t = unit -> 'a
    let return a = fun () -> a
    let (>>=) a f = fun () -> f (a ()) ()

    (** An extra function specific to Lazy
        [force l] forces the computation on l,
        immediately evaluating it to a value *)
    let force (l: 'a t): 'a = l ()
end

module NonDeterministic = struct
    type 'a t = 'a list

    (** [choose lst] returns a random element from a list [lst] *)
    let choose lst =
      let idx = List.length lst |> Int32.of_int |> Random.int32 |> Int32.to_int in
      List.nth lst idx

    let return a = [a]
    let (>>=) a f = a |> choose |> f
end
