# RNGPool.jl

This package provides a simple but hopefully useful interface to a Vector of ```Threads.nthreads()``` Threefry4x random number generators (RNGs). The Threefry4x RNGs are from the [RandomNumbers.jl](https://github.com/sunoru/RandomNumbers.jl) package.

Calling ```getRNG()``` will return the RNG associated to the thread on which it is called.

Calling ```setRNGs(v::Int64)``` sets the RNGs so that output is reproducible.

Example usage:

```julia
# on return, each element of out is the average of many Uniform(0,1) pseudo-random variates
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
