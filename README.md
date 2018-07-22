# RNGPool.jl

This package provides an interface to a Vector of Threads.nthreads() Threefry4x random number generators (RNGs).

The function call ```getRNG()``` will return the RNG associated to the thread calling it.

The function ```setRNGs(v::Int64)``` resets the RNGs so that output is reproducible.

Example usage:

```julia
function foo!(out::Vector{Float64}, N::Int64)
  nt = Threads.nthreads()
  M::Int64 = div(N, nt)
  Threads.@threads for i in 1:nt
    rng::RNG = getRNG()
    v::Float64 = 0.0
    for j in 1:M
      v += rand(rng)
    end
    out[i] = v / M
  end
end

nt = Threads.nthreads()
out = Vector{Float64}(undef, nt)

setRNGs(1)

N0 = 2^25
foo!(out, N0)
```
