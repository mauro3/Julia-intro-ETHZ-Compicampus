using PredatorPrey
using Plots
using BenchmarkTools

# parameters
α = 1.1
β = 0.4
δ = 0.1
γ = 0.4

# numerics
Δt = 0.01
nt = 10000

# initial condition
x0 = (10.0, 10.0)

out       = zeros(nt, 2)
out_naive = zeros(nt, 2)
out_fancy = zeros(nt, 2)

# solve ODEs in global scope
out[1, :] .= x0
@time for it in 2:nt
    r,f = out[it-1, :]
    out[it, :] .= out[it-1, :] .+ Δt .*  predator_prey(out[it-1,:], α, β, δ, γ) #[α*r - β * r * f, δ*r*f - γ*f]
end
t = 0:Δt:(nt-1)*Δt

# visualise results
plot(t, out; ylabel="population", label=["prey" "predator"], ls=[:solid :dash], lw=1.5)

# integrate ODEs using functions
@time t_naive, out_naive = integrate_naive!(...)
@time t_fancy, out_fancy = integrate_fancy!(...)

# visualise results
p1 = plot(...; ylabel="population", label=["prey" "predator"], title="explicit Euler", ls=[:solid :dash], lw=1.5)
p2 = plot(...; ylabel="predator", title="phase plot", lw=1.5, label=false)

p3 = plot(...; xlabel="time", ylabel="population", label=["prey" "predator"], title="semi-implicit Euler", ls=[:solid :dash], lw=1.5)
p4 = plot(...; xlabel="prey", ylabel="predator", title="phase plot", lw=1.5, label=false)

display(plot(p1, p2, p3, p4; layout=(2, 2), size=(640, 640)))

# benchmark implementations
@benchmark integrate_naive!(...)
@benchmark integrate_fancy!(...)
