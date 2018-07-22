# RNGPool.jl

[![Build Status](https://travis-ci.org/awllee/RNGPool.jl.svg?branch=master)](https://travis-ci.org/awllee/RNGPool.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/lip5qvw48dwjllau?svg=true)](https://ci.appveyor.com/project/awllee/rngpool-jl)
[![Coverage Status](https://coveralls.io/repos/github/awllee/RNGPool.jl/badge.svg?branch=master)](https://coveralls.io/github/awllee/RNGPool.jl?branch=master)
[![codecov.io](http://codecov.io/github/awllee/RNGPool.jl/coverage.svg?branch=master)](http://codecov.io/github/awllee/RNGPool.jl?branch=master)

This package provides a simple interface for thread-specific random number generators (RNGs).

Currently, Threefry4x RNGs are used, as implemented in [RandomNumbers.jl](https://github.com/sunoru/RandomNumbers.jl).

At runtime, a Vector of ```Threads.nthreads()``` RNGs is initialized when the package is loaded.

Calling ```getRNG()``` will return the RNG associated to the thread on which it is called.

Calling ```setRNGs(v::Int64)``` sets the RNGs so that output is reproducible.

Example usage:

```julia
using RNGPool
import Compat.undef
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
