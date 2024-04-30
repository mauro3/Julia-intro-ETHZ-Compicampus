module PredatorPrey

export predator_prey, integrate_naive!, integrate_fancy!

"""
    predator_prey(x, α, β, δ, γ)

Returns the right-hand side of Lotka-Volterra system ODE.
"""
function predator_prey(x, α, β, δ, γ)
    return α * x[1] - β * x[1] * x[2],
           δ * x[1] * x[2] - γ * x[2]
end

"""
    integrate_naive!(out, x0, α, β, δ, γ, Δt, nt)

Integrate Lotka-Volterra ODE system with exlicit Euler time integrator.
Returns array of time steps and array of prey and predator populations.
"""
function integrate_naive!(out, x0, α, β, δ, γ, Δt, nt)
    out[1, :] .= x0
    for it in 2:nt
        out[it, :] .= out[it-1, :] .+ Δt .* predator_prey(out[it-1, :], α, β, δ, γ)
    end
    t = range(0, (nt - 1) * Δt, nt)
    return t, out
end

"""
    integrate_fancy!(out, x0, α, β, δ, γ, Δt, nt)

Integrate Lotka-Volterra ODE system in Hamiltonian form with semi-implicit Euler time integrator.
Returns array of time steps and array of prey and predator populations.
"""
function integrate_fancy!(out, x0, α, β, δ, γ, Δt, nt)
    out[1, :] .= x0
    for it in 2:nt
        out[it, 1] = exp(log(out[it-1, 1]) + Δt * (α - β * out[it-1, 2]))
        out[it, 2] = exp(log(out[it-1, 2]) + Δt * (δ * out[it, 1] - γ))
    end
    t = range(0, (nt - 1) * Δt, nt)
    return t, out
end

end # module PredatorPrey
