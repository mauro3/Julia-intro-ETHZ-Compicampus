using PredatorPrey
using Plots
using BenchmarkTools

# parameters
α = 1.1
β = 0.4
δ = 0.1
γ = 0.4

# numerics
Δt = 0.1
nt = 1000

# initial condition
x0 = (10.0, 10.0)

# allocate arrays
out1 = zeros(nt, 2)
out2 = zeros(nt, 2)

# integrate ODE
t1, out1 = integrate_naive!(...)
t2, out2 = integrate_fancy!(...)

# visualise results
p1 = plot(...; ylabel="population", label=["prey" "predator"], title="explicit Euler", ls=[:solid :dash], lw=1.5)
p2 = plot(...; ylabel="predator", title="phase plot", lw=1.5, label=false)

p3 = plot(...; xlabel="time", ylabel="population", label=["prey" "predator"], title="semi-implicit Euler", ls=[:solid :dash], lw=1.5)
p4 = plot(...; xlabel="prey", ylabel="predator", title="phase plot", lw=1.5, label=false)

display(plot(p1, p2, p3, p4; layout=(2, 2), size=(640, 640)))

# benchmark implementations
@benchmark integrate_naive!(...)
@benchmark integrate_fancy!(...)
