open Equal

(** Represents a key-value mapping. *)
module type Map = sig
  (** Type of this map. *)
  type 'a t

  (** Type of keys. *)
  type key

  (** [empty] is a map with no bindings. *)
  val empty: 'a t

  (** [add k v map] is [map] with new binding [k -> v]. *)
  val add: key -> 'a -> 'a t -> 'a t

  (** [get k map] is [Some v] if [map] contains binding [k -> v]
    * or None otherwise. *)
  val get: key -> 'a t -> 'a option
end

module type Maker = functor (K : Equatable) -> Map with type key = K.t

module MakeList (K : Equatable) : (Map with type key = K.t) = struct

  type 'a t = (K.t * 'a) list

  type key = K.t

  let empty =
    []

  let add k v map =
    (k, v) :: map

  let rec get k map = match map with
  | []                          -> None
  | (k', v) :: t when K.eq k k' -> Some v
  | _       :: t                -> get k t
end

module MakeFun (K : Equatable) : (Map with type key = K.t) = struct

  type 'a t = K.t -> 'a option

  type key = K.t

  let empty =
    fun _ -> None

  let add k v map =
    fun k' -> if K.eq k k' then Some v else map k'

  let get k map =
    map k

end
