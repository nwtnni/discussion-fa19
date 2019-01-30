# Exercises

## `types.ml`

This file contains a series of functions. Try and figure out their type!
If you get stuck or want to check your answers, you can always paste the function into `utop`.

```
utop # let f x = x;;
val f : 'a -> 'a = <fun>
```

## `calculus.ml`

This file implements some mathematical functions as OCaml functions. The goal is to
become more comfortable with treating functions as values: passing them to functions
and returning them from functions. You're looking for anything that says
`failwith "Unimplemented"`: there are some other functions that are already provided.

In math, it's easy to write operations on functions:

```
h(x) = f(x) + g(x)
df(x) = d/dx f(x)
```

Hopefully you'll see it's almost as easy in OCaml!

You can use the provided Makefile to build your code (and clean up build artifacts when you're done):

```
make
make clean
```

This compiles an executable `.byte` file, which will run the "main" function at the bottom
of `calculus.ml`. Feel free to change this entrypoint to evaluate different functions!
You can save the output of the executable by redirecting it to a file, like so:

```
./calculus.byte > data.csv
```

A short Python script for plotting the data is included. Assuming you have Python installed,
you can plot the data with the following command:

```
python plot.py data.csv
```
