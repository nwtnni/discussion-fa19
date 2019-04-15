build:
	ocamlbuild -use-menhir -use-ocamlfind eval.byte

sol:
	ocamlbuild -use-menhir -use-ocamlfind eval_sol.byte && mv eval_sol.byte sol.byte

clean:
	ocamlbuild -clean
