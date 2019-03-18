(** What's wrong with this implementation? *)
let counter =
  fun () ->
    let state = ref 0 in
    let next = !state in
    state := !state + 1;
    next

(** Implement a counter that correctly maintains state *)
let counter =
  let state = ref 0 in
  fun () ->
    let next = !state in
    state := !state + 1;
    next
