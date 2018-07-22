using RNGTest
using Compat.Test

include("circularRNG.jl")

@time out = RNGTest.bigcrushJulia(generator)
println("\nBig Crush p-values:\n")
for i in eachindex(out)
  println(out[i])
end
minpv = 1.0
for i in eachindex(out)
  minpv = min(minpv, minimum(out[i]))
  @test minimum(out[i]) > 1e-4
end
println("Smallest p-value = ", minpv)
