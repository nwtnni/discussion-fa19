module Set = Set.Make (String)

type command =
| Drop
| Take
| Go of string

type state = {
  here: string;
  drop: Set.t;
  next: command -> state;
}

let read_command () : command =
  let input = read_line () in
  let regex = Str.regexp_string " " in
  match Str.bounded_split regex input 2 with
  | "drop" :: _           -> Drop
  | "take" :: _           -> Take
  | "go"   :: there :: [] -> Go there
  | _ -> failwith "Invalid command"

let rec make (start: string) (drop: Set.t) =
  let here = start in
  let drop = drop in
  let next = function
  | Drop -> make start (Set.add start drop)
  | Take -> make start (Set.remove start drop)
  | Go there -> make there drop
  in
  { here; drop; next }

let string_of_state (s: state) : string =
  Printf.sprintf
    "Currently in room %s. %s"
    s.here 
    begin if Set.mem s.here s.drop then "There is a crumb here." else "" end

let rec loop state = 
  state |> string_of_state
        |> print_endline
        |> read_command
        |> state.next
        |> loop

let _ = loop (make "Phillips 307" Set.empty)
