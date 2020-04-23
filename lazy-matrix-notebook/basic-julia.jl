# Using a registered Julia package in our code
using LinearAlgebra # access to det, tr, \ backslash solve

abstract type LazyMatrix{T} <: AbstractArray{T,2} end

# Squared Matrix with entries A_ij = alpha*i + beta*j
# Not inheriting fields from Julia Array
struct MyLazyMatrix{T} <: LazyMatrix{T}
  dim
  alpha
  beta
end

# Implement the AbstractArray interface
import Base: IndexStyle
import Base: size
import Base: getindex

# Just implement the abstract interface
IndexStyle(::Type{MyLazyMatrix{T}} where {T}) = IndexCartesian()
size(a::MyLazyMatrix{T}) where T = (a.dim,a.dim)
function getindex(A::MyLazyMatrix{T}, I::Vararg{Int,2}) where T
  A.alpha*I[1] + A.beta*I[2]
end


b = [1.0,1.0]
a = MyLazyMatrix{Float64}(2,0.5,1.5)
x2 = a\b # implemented in Julia
a+a # Implemented in Julia
2*a # Implemented in Julia


typeof(a) # My Lazy matrix, no memory
typeof(2.0*a) # A Julia Array, in memory, not lazy
typeof(a+a) # A Julia Array, in memory, not lazy

# Lazy unary operations over LazyMatrix
struct UnaryOpLazyMatrix{T} <: LazyMatrix{T}
  fun
  mat::LazyMatrix{T}
end

IndexStyle(::Type{UnaryOpLazyMatrix{T}} where {T}) = IndexCartesian()
size(self::UnaryOpLazyMatrix{T}) where T = size(self.mat)
function getindex(self::UnaryOpLazyMatrix{T}, I::Vararg{Int,2}) where T
  self.fun(self.mat[I[1],I[2]])
end

myfun(x) = x^3+2
myfun_a = UnaryOpLazyMatrix(myfun,a)

import Base: *, sqrt

# Syntatic sugar
*(α::Number,a::LazyMatrix) = UnaryOpLazyMatrix(x -> α*x, a)
# Functions are first class citizens (anonymous function)
sqrt(a::LazyMatrix) = UnaryOpLazyMatrix(sqrt, a)

# Now, lazy operations
typeof(5*a)
typeof(sqrt(a))

# Lazy binary operations over LazyMatrix
struct BinaryOpLazyMatrix{T} <: LazyMatrix{T}
  op
  mat1::LazyMatrix{T}
  mat2::LazyMatrix{T}
end

IndexStyle(::Type{BinaryOpLazyMatrix{T}} where {T}) = IndexCartesian()
size(self::BinaryOpLazyMatrix{T}) where T = size(self.mat1)
function getindex(self::BinaryOpLazyMatrix{T}, I::Vararg{Int,2}) where T
  self.op(self.mat1[I[1],I[2]],self.mat2[I[1],I[2]])
end


# Syntatic sugar
import Base: +, -

for op in (:+,:-)
  # Metaprogramming
  @eval begin
    $op(a::LazyMatrix,b::LazyMatrix) = BinaryOpLazyMatrix{eltype(a)}($op,a,b)
  end
end

b = MyLazyMatrix{Float64}(2,0.5,2.5)
typeof(a+b)
typeof(a-b)

c = MyLazyMatrix{Float64}(2,5.0,2.5)
typeof(5*a+2*b+c) # lazy

# All the computation here (lazy evaluation)
# Ummutable objects, lazy == cheap
det(sqrt(a)+5*a-b)

# Duck typing example
d = UnaryOpLazyMatrix("a",a);
size(d)
d[1,1]
