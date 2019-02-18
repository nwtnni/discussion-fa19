open Equal
open OUnit2

module TestMaker (Make: Map.Maker) = struct

  module IntMap = Make (Int)

  let make_test left right =
    fun _ -> assert_equal left right

  let int_tests = let open IntMap in [
    ("Get from empty map" >:: make_test
      (empty |> get 0)
      None);

    ("Add one element" >:: make_test
      (empty |> add 0 0 |> get 0)
      (Some 0));

    ("Overwrite one element" >:: make_test
      (empty |> add 0 0 |> add 0 1 |> get 0)
      (Some 1));

    ("Add several elements" >:: make_test
      (empty |> add 0 0 |> add 1 1 |> add 2 2 |> get 1)
      (Some 1));

    ("Add colliding values" >:: make_test
      (empty |> add 0 0 |> add 1 0 |> add 2 0 |> get 0)
      (Some 0));

    ("Overwrite early element" >:: make_test
      (empty |> add 0 0 |> add 1 5 |> add 0 100 |> add 2 10 |> get 0)
      (Some 100));
  ]

  module HumanMap = Make (Human)

  let human_tests = let open HumanMap in [
    ("Check custom equality" >:: make_test
      (empty |> add { id = 0; name = "Robert" } 0
             |> add { id = 0; name = "Bob" } 1
             |> get { id = 0; name = "Rob" })
      (Some 1));
  ]

  let tests = int_tests @ human_tests

end

module ListTests = TestMaker (Map.MakeList)
module FunTests = TestMaker (Map.MakeFun)

let suite = "Map test suite" >::: (ListTests.tests @ FunTests.tests)
let _ = run_test_tt_main suite
