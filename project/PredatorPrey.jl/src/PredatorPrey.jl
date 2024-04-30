module PredatorPrey

export predator_prey, integrate_naive!, integrate_fancy!

"""
    predator_prey(x, α, β, δ, γ)

Returns the right-hand side of Lotka-Volterra system ODE.
"""
function predator_prey(...)
    return ...
end

"""
    integrate_naive!(out, x0, α, β, δ, γ, Δt, nt)

Integrate Lotka-Volterra ODE system with explicit Euler time integrator.
Returns array of time steps and array of prey and predator populations.
"""
function integrate_naive!(...)
    out[1, :] .= ...
    for it in 2:nt
        out[it, :] .= out[it-1, :] .+ ...
    end
    t = range(0, ..., nt)
    return t, out
end

"""
    integrate_fancy!(out, x0, α, β, δ, γ, Δt, nt)

Integrate Lotka-Volterra ODE system with semi-implicit Euler time integrator.
Returns array of time steps and array of prey and predator populations.
"""
function integrate_fancy!(...)
    out[1, :] .= ...
    for it in 2:nt
        out[it, 1] = out[it-1, 1] + ...
        out[it, 2] = out[it-1, 2] + ...
    end
    t = range(0, ..., nt)
    return t, out
end

end # module PredatorPrey
