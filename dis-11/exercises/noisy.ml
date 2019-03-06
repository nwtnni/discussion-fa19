let noisy_zero : int =
  print_endline "HELLO, THIS IS 0";
  0

let noisy (number : int) =
  Printf.printf "HELLO, THIS IS %i\n" number;
  number

let print_eager (number: int) : unit =
  Printf.printf "PRINTING...\n";
  Printf.printf "%i\n" number

let print_lazy (number: unit -> int) : unit =
  Printf.printf "PRINTING...\n";
  Printf.printf "%i\n" (number ())
