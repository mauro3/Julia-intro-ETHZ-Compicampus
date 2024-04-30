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
out       = zeros(nt, 2)
out_naive = zeros(nt, 2)
out_fancy = zeros(nt, 2)

# solve ODEs in global scope
out[1, :] .= x0
@time for it in 2:nt
    out[it, :] .= out[it-1, :] .+ Δt .* predator_prey(out[it-1, :], α, β, δ, γ)
end
t = range(0, (nt - 1) * Δt, nt)

# visualise results
plot(t, out; ylabel="population", label=["prey" "predator"], ls=[:solid :dash], lw=1.5)

# integrate ODEs using functions
@time t_naive, out_naive = integrate_naive!(out_naive, x0, α, β, δ, γ, Δt, nt)
@time t_fancy, out_fancy = integrate_fancy!(out_fancy, x0, α, β, δ, γ, Δt, nt)

# visualise results
p1 = plot(t_naive, out_naive; ylabel="population", label=["prey" "predator"], title="explicit Euler", ls=[:solid :dash], lw=1.5)
p2 = plot(out_naive[:, 1], out_naive[:, 2]; ylabel="predator", title="phase plot", lw=1.5, label=false)

p3 = plot(t_fancy, out_fancy; xlabel="time", ylabel="population", label=["prey" "predator"], ls=[:solid :dash], lw=1.5)
p4 = plot(out_fancy[:, 1], out_fancy[:, 2]; xlabel="prey", ylabel="predator", title="phase plot", lw=1.5, label=false)

plot(p1, p2, p3, p4; layout=(2, 2), size=(640, 640))

# benchmark implementations
@benchmark integrate_naive!($out_naive, $x0, $α, $β, $δ, $γ, $Δt, $nt)
@benchmark integrate_fancy!($out_fancy, $x0, $α, $β, $δ, $γ, $Δt, $nt)
