module type Foldable = sig
  type 'a t
  val fold: ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a
end

module type Listable = sig
  type 'a t
  val to_list: 'a t -> 'a list
end

module ListFromFold (F: Foldable) : Listable with type 'a t = 'a F.t = struct

  type 'a t = 'a F.t

  let to_list v =
    failwith "Unimplemented"

end

module type Updateable = sig
  type 'a t
  val update: 'a -> 'a t -> 'a t
end

module type Mappable = sig
  type 'a t
  val map: ('a -> 'b) -> 'a t -> 'b t
end

module type Newable = sig
  type 'a t
  val empty: 'a t
end

(* Foldable, updateable, and newable *)
module type FUN = sig
  include Foldable  
  include Updateable with type 'a t := 'a t
  include Newable with type 'a t := 'a t
end

module MapFromFold (F: FUN) : Mappable with type 'a t = 'a F.t = struct

  type 'a t = 'a F.t

  let map f v =
    failwith "Unimplemented"

end

module type Constructable = sig
  type 'a t
  val construct: 'a list -> 'a t
end

module type UN = sig
  include Updateable
  include Newable with type 'a t := 'a t
end

module ConstructFromUpdate (U: UN) : Constructable with type 'a t = 'a U.t = struct

  type 'a t = 'a U.t

  let construct l =
    failwith "Unimplemented"

end
