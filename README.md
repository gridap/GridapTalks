# Gridap Talks

In this repos you can find some material I have recently develop for presenting the `Gridap` library.

You can find the slides of the **Monash Workshop on Numerical Differential Equations with Applications**, Melbourne, February 14th 2020 2, [here](https://github.com/santiagobadia/Gridap-presentation/blob/master/MWNDEA-Melbourne/beamer-version/sbadia-mwndea.pdf) and the slides of the **UNSW Online Computational Mathematics Seminar**, Melbourne-Sydney, April 21st 2020, [here](https://github.com/santiagobadia/Gridap-presentation/blob/master/UNSW-comp-math-seminar/beamer-version/sbadia-unsw.pdf), together with the video recording of the online seminar that you can download from [here](https://github.com/santiagobadia/Gridap-presentation/blob/master/unsw-video/unsw-gridap-seminar-compressed.mp4).

You can also find a jupyter [notebook](https://github.com/santiagobadia/Gridap-presentation/blob/master/lazy-matrix-notebook/julia-basics.ipynb) in which I have created a very simple example of a _lazy ummutable matrix_ implementation in `Julia`, which I consider provides a nice overview of the `Julia` capabilities, its multiple dispatching paradigm, the importance of interfaces and _group by actions, not attributes_. I think it can be useful for people that come from object-oriented backgrounds. This example also provides some insight about how we have been able to implement our numerical PDE solvers in `Gridap`, as I explain in the presentations.

To install the jupyter notebooks, do the following

```
$ git clone https://github.com/gridap/Tutorials.git
```

Move into the folder and open a Julia REPL setting the current folder as the project environment

```
$ cd Gridap-presentation/lazy-matrix-notebook/
$ julia
```
In the Julia REPL
```
julia> 
```
type `]` to enter in pkg mode, activate the project
```
(@v1.4) pkg> activate .
```
and instantiate the environment
```
(lazy-matrix-notebook) pkg> instantiate
```
Open the notebook using these commands
```
julia> using IJulia
julia> notebook(dir=pwd())
```
Enjoy!
