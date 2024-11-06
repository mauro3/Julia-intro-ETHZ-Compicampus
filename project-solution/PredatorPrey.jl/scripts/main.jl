using PredatorPrey, GLMakie, BenchmarkTools

# parameters
α = 1.1
β = 0.4
γ = 0.4
δ = 0.1

# total time of integration
ttot = 100.0

# numerics
nt = 1000 # increase the number of time steps to get more accurate results
Δt = ttot / nt

# initial condition
x0, y0 = 10.0, 10.0

# allocate arrays
out1 = zeros(nt + 1, 2)
out2 = zeros(nt + 1, 2)

# solve ODEs in global scope using explicit Euler integration
out1[1, :] .= x0, y0
@time for it in 2:nt+1
    df_dt = predator_prey(out1[it-1, 1], out1[it-1, 2], α, β, γ, δ)
    out1[it, :] .= out1[it-1, :] .+ Δt .* df_dt
end
t1 = range(0, ttot, nt + 1)

# visualise the results
fig = Figure()

ax1 = Axis(fig[1, 1]; xlabel="time", ylabel="population", title="explicit Euler")
series!(ax1, t1, out1'; labels=["prey", "predator"]); axislegend(ax1)

# solve the same ODEs using the function from the module that you've implemented
@time t2, out2 = integrate!(out2, x0, y0, α, β, γ, δ, Δt, nt)

ax2 = Axis(fig[1, 2]; xlabel="time", ylabel="population", title="semi-implicit Euler")
series!(ax2, t2, out2'; labels=["prey", "predator"]); axislegend(ax2)

# phase plots of prey vs predator populations
ax3 = Axis(fig[2, 1]; xlabel="prey", ylabel="predator")
ax4 = Axis(fig[2, 2]; xlabel="prey", ylabel="predator")

lines!(ax3, out1[:, 1], out1[:, 2])
lines!(ax4, out2[:, 1], out2[:, 2])

# benchmark the implementation (hint: prepend each argument with '$')
@benchmark integrate!($out2, $x0, $y0, $α, $β, $γ, $δ, $Δt, $nt)
