module Integer = struct

  (**
   * AF:
   *
   * RI:
   *
   *)
  type t = int

  let rep_ok n =
    failwith "Unimplemented"

end

module Peano = struct

  (**
   * AF:
   *
   * RI:
   *
   *)
  type t =
  | O
  | S of t

  let rep_ok n =
    failwith "Unimplemented"

end
