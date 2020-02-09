---
output: pdf_document
bibliography: erc-proposal.bib
csl: aiaa-journal.csl
header-includes:
  - \usepackage{unicode-math}
  - \usepackage{amsmath}
  - \usepackage{graphicx}
  - \setmainfont{Times New Roman}
---

# Gridap: Grid-based PDE approximations in Julia (Santiago Badia and Francesc Verdugo)

## Numerical PDE discretisations

Advanced PDE solvers are *complex*

* Plethora of discretisations: Grad, curl, and div-conforming FEs, hybridisable and virtual elements, discontinuous Galerkin, unfitted and CutFEM schemes

* Complex PDEs: Multiphysics, nonlinear, multiscale, complex constitutive models

* Nonlinear approximation: h-adaptive and p-adaptive methods

* Multiscale methods and multilevel solvers: Strong coupling between functional setting and solvers (not black-box)

* Uncertainty and quantification: intrusive polynomial chaos, (mutilevel) (quasi) Monte Carlo methods, etc

* Nonlinear preconditioning, inverse problems, data-driven parameter identification [...]

* Large scale computations: distributed-memory implementations

We want to combine many ingredients!

## Existing libraries

Excellent pool of high-performance libraries: deal.ii, fenics, FEMPAR, MOOSE, libmesh, Firedrake, DUNE, etc.

* C++ or OO FORTRAN08 (static/compiled languages), some w/ Python interfaces (dynamic languages)

* Excellent if they provide all you need (*user*)

* Far more involved if not (*library developer*)

## Computational math research

PhD students (3-4y), postdocs (1-3y)

* Starting from scratch every time not an option (hard to reach state-of-the-art interface)

* New algorithms to be implemented, may involve extensions of the library core

* Get into these libraries is *very time-consuming*

## Dynamically- vs. statically-typed languages

Dynamically-typed languages:

* **Productivity**: More expressive, no compilation step (problematic for large libraries), interactive development (debugging on-the-fly), better for math-related bugs (no benefit from static compilation), no set-up of environment (compilers, system libraries, etc)

Statically-typed languages:

* **Performance**: Compilers generate highly optimised code

## Solutions

* Dynamic-static combinations: Vectorised PDE solvers in Python + external pre-compiled libraries (NumPy); high-level Python interface of a static PDE library (fenics), etc.

* Constraints over the dynamic code (e.g. vectorisation)

* 2-language barrier: When changes require to get into static library

## Julia: a new paradigm

Aim: Productivity *and* performance

* Productive: Dynamic language

* Performant: Advanced type-inference system + just-in-time (JIT) compilation

* 21st century FORTRAN, designed from inception for numerical computations (MIT, 2011-)

* Solve previous issues: for-loops not a problem, *everything* can be in Julia

Let us give it a try!

## Julia features

* Multiple dispatching paradigm: functions not bound to types, dispatching wrt all arguments (solving multiple inheritance issues)

* Not OO: No inheritance of concrete types (only abstract types), *use composition, not inheritance*, *classify by their actions, not their attributes*...

* Performant Julia code is not obvious: help JIT compiler to infer types, *type-stability* to create performant code

## Julia features

* Package manager is awesome

```julia
add "Gridap"
```

* Every project comes with its list of dependencies (automatic process)

* Seamless integration with `Github` (register packages, etc)

* Excellent deployment of automatically-generated code documentation in `Github`

* Unit testing and performance tools [...]

## Implementing grid-based PDE methods in Julia

Some key decisions:

* Functional-like style i.e. immutable objects, no *state diagram* (just some cache arrays for performance)

* Lazy evaluation of expressions (e.g. implement unary/binary expression trees for types)

## CellFields

The core of `Gridap` are the `CellFields` types

`CellField`: It represent an array of fields (one, vector,...) per cells (e.g. edges, faces, cells in a mesh), where a `Field` provides a physical quantity (n-tensor) per space(-time) point in a mainfold

With these objects, we represent FE functions, FE bases, etc.

We also implement operations:

* Unary operations: e.g. `∇()`, `∇×()`, `∇⋅()`, etc.
* Binary operations: `inner(,)`,`×`, etc.

## Gridap in action

Let us go to [Gridap tutorial 1](www.google.com)

```julia
g(x) = 2.0
V0 = TestFESpace(V)
Ug = TrialFESpace(V,g)

f(x) = 1.0
a(v,u) = inner( ∇(v), ∇(u) )
b_Ω(v) = inner(v, f)
t_Ω = AffineFETerm(a,b_Ω,trian,quad)

op = LinearFEOperator(V0,Ug,b_Ω,t_Ω)
```
* Nesting objects into other objects via composition (mesh in FE space in FE function + bilinear form (duck typing) + triangulation + quadrature in FE operator...). All objects are immutable

* No numerical computations at this stage, just creating the expression tree (`∇()` and `inner`)

* Numerically intensive computations deployed here

```julia
uh = solve(solver,op)
```

## Example: Nonlinear elasticity

Let us take a look at this [tutorial](www.google.com)

## `Gridap` status

Gridap seed started in Christmas 2018 (1y ago)... trying to find ways to increase productivity in the team. Now we have (big thanks to F Verdugo's amazing work at UPC):

* Lagrangian, Raviart-Thomas, Nedelec [...] FE spaces
* Discontinuous Galerkin methods
* Multifield or multiphysics methods
* Interaction with GMesh, Pardiso, PETSc [...]
* dimension-agnostic (5-dim Laplacian solved), order-agnostic

Quite complete [documentation](), [tutorials]()

Dream: same software for research and teaching!

* One undergrad AMSI project on `Gridap`: from no idea about FEs/coding to MRI data of velocity of patient-specific aorta to pressure fields via in 2 months
* FE tutorials in *MTH5321 - Methods of computational mathematics*

## Next steps

Hopefully, this is just the beginning

* Distributed-memory implementation
* h-adaptivity (`p4est` interface)
* Space-time unfitted FE methods for moving interfaces (Martin and Neiva's talks)
* Historic variables for nonlinear solid mechanics
* Virtual element methods
* Interface w/ BDDC large scale solvers in `FEMPAR`

Performance/productivity analysis:

* Running FE problems with $O(10^6)$ cells in my desktop in a similar time as `FEMPAR` but *no performance analysis* (x2-3 `FEMPAR` not a problem anyway if x2-3 productivity)

![Just to check figures](/home/santiago/github-repos/private-repos/future-fellowship-2020/proposal/fig_spacetime_c.pdf){#fig:stf width=50%}
