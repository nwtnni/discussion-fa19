module Integer = struct

  (**
   * AF:
   *
   * RI:
   *
   *)
  type t = int

  let rep_ok b =
    failwith "Unimplemented"

end

module String = struct

  (**
   * AF:
   *
   * RI:
   *
   *)
  type t = string

  let rep_ok b =
    failwith "Unimplemented"

end

module Variant = struct

  (**
   * AF:
   *
   * RI:
   *
   *)
  type t =
  | True
  | False

  let rep_ok b =
    failwith "Unimplemented"

end
