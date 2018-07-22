include("parallelGeneration.jl")

import Compat.undef

setRNGs(1)
nt = Threads.nthreads()
out = Vector{Float64}(undef, nt)

using BenchmarkTools
N0 = 2^25
@btime foo!($out, $N0)
