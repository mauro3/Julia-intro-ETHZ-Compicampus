module PredatorPrey

export d🐰_dt, d🦊_dt, predator_prey, integrate!

"""
    d🐰_dt(🐰, 🦊, α, β)

Returns the right-hand side of the Lotka-Volterra ODE for prey.
"""
d🐰_dt(🐰, 🦊, α, β) = α * 🐰 - β * 🐰 * 🦊

"""
    d🦊_dt(🐰, 🦊, γ, δ)

Returns the right-hand side of the Lotka-Volterra ODE for predator.
"""
d🦊_dt(🐰, 🦊, γ, δ) = δ * 🐰 * 🦊 - γ * 🦊

"""
    predator_prey(🐰, 🦊, α, β, γ, δ)

Returns the right-hand side of the Lotka-Volterra ODE system.
"""
predator_prey(🐰, 🦊, α, β, γ, δ) = d🐰_dt(🐰, 🦊, α, β), d🦊_dt(🐰, 🦊, γ, δ)

"""
    integrate!(out, 🐰0, 🦊0, α, β, γ, δ, Δt, nt)

Integrate Lotka-Volterra ODE system with semi-implicit Euler time integrator.
Returns array of time steps and array of prey and predator populations.
"""
function integrate!(out, 🐰0, 🦊0, α, β, γ, δ, Δt, nt)
    out[1, :] .= 🐰0, 🦊0
    for it in 2:nt+1
        # hint: use the values from previous time step for both 🐰 and 🦊
        out[it, 1] = out[it-1, 1] + Δt * d🐰_dt(out[it-1, 1], out[it-1, 2], α, β)
        # hint: use the freshly computed value of 🐰 from the current time step
        # and the value of 🦊 from the previous time step
        out[it, 2] = out[it-1, 2] + Δt * d🦊_dt(out[it, 1], out[it-1, 2], γ, δ)
    end
    t = range(0, nt * Δt, nt + 1)
    return t, out
end

end # module PredatorPrey
