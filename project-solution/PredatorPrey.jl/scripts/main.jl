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
t1, out1 = integrate_naive!(out1, x0, α, β, δ, γ, Δt, nt)
t2, out2 = integrate_fancy!(out2, x0, α, β, δ, γ, Δt, nt)

# visualise results
p1 = plot(t1, out1; ylabel="population", label=["prey" "predator"], title="explicit Euler", ls=[:solid :dash], lw=1.5)
p2 = plot(out1[:, 1], out1[:, 2]; ylabel="predator", title="phase plot", lw=1.5, label=false)

p3 = plot(t2, out2; xlabel="time", ylabel="population", label=["prey" "predator"], title="semi-implicit Euler", ls=[:solid :dash], lw=1.5)
p4 = plot(out2[:, 1], out2[:, 2]; xlabel="prey", ylabel="predator", title="phase plot", lw=1.5, label=false)

display(plot(p1, p2, p3, p4; layout=(2, 2), size=(640, 640)))

# benchmark implementations
@benchmark integrate_naive!($out1, $x0, $α, $β, $δ, $γ, $Δt, $nt)
@benchmark integrate_fancy!($out2, $x0, $α, $β, $δ, $γ, $Δt, $nt)
