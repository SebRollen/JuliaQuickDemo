using LinearAlgebra

function inner_sum(A, vs)
    t = zero(eltype(A))
    for v in vs
        t += inner(v, A, v)
    end
    return t
end

inner(v, A, w) = dot(v, A*w)

A = rand(3, 3)
vs = [rand(3) for _ in 1:4]
inner_sum(A, vs)
inner_sum(A, [1:3, 2:4])

import Base: size, getindex, *

struct BasisVector <: AbstractVector{Bool}
    len :: Int
    ind :: Int
end

size(v::BasisVector) = (v.len,)
getindex(v::BasisVector, i::Integer) = i == v.ind

vs = [BasisVector(3, rand(1:3)) for _ in 1:4]
inner_sum(A, vs)

using BenchmarkTools
@btime inner_sum(A, vs)

*(A::AbstractMatrix, v::BasisVector) = A[:, v.ind]
@btime inner_sum(A, vs)

inner(v::BasisVector, A, w::BasisVector) = A[v.ind, w.ind]
@btime inner_sum(A, vs)
