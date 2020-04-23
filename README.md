# Gridap presentations

In this repos you can find some material we have recently develop for presenting the `Gridap` library.

You can find the slides of the **Monash Workshop on Numerical Differential Equations with Applications**, Melbourne, February 2020 2, [here]() and the slides of the **UNSW Online Computational Mathematics Seminar**, Melbourne-Sydney, April 2020, [here](), together with the video recording of the online seminar [here](). All this material has been delivered by [Santiago Badia]().

You can also find a jupyter notebook in which I have created a very simple example of a _lazy ummutable matrix_ implementation in `Julia`, which I consider provides a nice overview of the `Julia` capabilities, its multiple dispatching paradigm, the importance of interfaces and _group by actions, not attributes_. I think it can be useful for people that come from object-oriented backgrounds. This example also provides some insight about how we have been able to implement our `numerical PDE solvers` in `Gridap`, as I try to explain in the presentations.

To install the jupyter notebooks, do the following:

```
$ git clone https://github.com/gridap/Tutorials.git
```

Move into the folder and open a Julia REPL setting the current folder as the project environment.

```
$ cd Gridap-presentation/lazy-matrix-notebook/
$ julia
```
In the Julia REPL
```
julia> 
```
Type `]` to enter in pkg mode, activate the project
```
(@v1.4) pkg> activate .
```
and instantiate the envorinment
```
(lazy-matrix-notebook) pkg> instantiate
```
Open the notebook using these commands
```
julia> using IJulia
julia> notebook(dir=pwd())
```



