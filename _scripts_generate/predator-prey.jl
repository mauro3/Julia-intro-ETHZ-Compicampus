#src # This is needed to make this run as normal Julia file:
using Markdown #src

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### 🔨 Hands-on II: implementing predator-prey model

Let's do some scientific programming in Julia!
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
- we'll implement the so-called predator-prey model
- it describes the dynamics of a biological system with two interacting species
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
- a predator 🦊 ...
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
- and a prey 🐰
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### Lotka-Volterra model

The predator-prey system can be described as a system of ODEs, called a _Lotka-Volterra model_:

$$
\frac{\mathrm{d}}{\mathrm{d}t}🐰 = \alpha \cdot 🐰 - \beta \cdot 🐰 \cdot 🦊
$$

$$
\frac{\mathrm{d}}{\mathrm{d}t}🦊 = \delta \cdot 🐰 \cdot 🦊 - \gamma \cdot 🦊
$$

- $\alpha$ and $\gamma$ are prey's growth rate and predator's death rate
- $\beta$ and $\delta$ are interaction parameters between species
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### Expected output

<center><img src="./figures/l1_predator-prey.png" alt="predator-prey" width="50%"/><center/>
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### Tasks

1. Implement the right-hand side of Lotka-Volterra system inside the functions `dx_dt`, `dx_dt`, and `predator_prey`

2. Implement the time integration loop within a single cell
    1. Measure the execution time with the `@time` macro
    2. Experiment with the time step by changing `nt`, see how the solution changes with decreasing `Δt`

    > The implementation is very similar to the one for the Lorenz attractor from the introduction
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
3. Implement non-allocating version of the time integration in the function `integrate!`
    1. Split the line within the time loop into two, updating the population of each species independently
    2. Call `integrate!`, time the results with the `@time` macro, compare to the execution time in the global scope
    3. Replace `out[it-1, 1]` with `out[it, 1]` in the second line (update rule for `out[it, 2]`) to make the integration semi-implicit
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Let's introduce physical parameters:
"""

using CairoMakie, BenchmarkTools

## parameters
α = 1.1
β = 0.4
γ = 0.4
δ = 0.1

## total time of integration
ttot = 100.0

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
Then numerics:
"""

nt = 1000 # increase the number of time steps to get more accurate results
Δt = ttot / nt

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
And initial conditions:
"""

x0, y0 = 10.0, 10.0

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Allocate arrays to store both explicit and semi-implicit solutions
"""

out1 = zeros(nt + 1, 2)
out2 = zeros(nt + 1, 2)

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Let's implement the Lotka-Volterra equations:
"""

#hint dx_dt(x, y, α, β) = ...
#hint dy_dt(x, y, γ, δ) = ...
#sol dx_dt(x, y, α, β) = α * x - β * x * y
#sol dy_dt(x, y, γ, δ) = δ * x * y - γ * y

#hint predator_prey(x, y, α, β, γ, δ) = ..., ...
#sol predator_prey(x, y, α, β, γ, δ) = dx_dt(x, y, α, β), dy_dt(x, y, γ, δ)

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Now we can solve ODEs in global scope using explicit Euler integration:
"""

out1[1, :] .= x0, y0
@time for it in 2:nt+1
    #hint df_dt = ...
    #hint out1[it, :] .= ...
    #sol df_dt = predator_prey(out1[it-1, 1], out1[it-1, 2], α, β, γ, δ)
    #sol out1[it, :] .= out1[it-1, :] .+ Δt .* df_dt
end

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Visualise the results:
"""


fig = Figure()

ax1 = Axis(fig[1, 1]; xlabel="time", ylabel="population", title="explicit Euler")

t1 = range(0, ttot, nt + 1)

series!(ax1, t1, out1'; labels=["prey", "predator"]);
axislegend(ax1);

fig

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Well done! 🚀

However, the results don't look quite like we expect, both predator and prey populations seem to grow over time!
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
👉 Try to increase the number of time steps to `nt = 10000` and verify that the solution becomes more accurate.
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Now let's implement the `integrate!` function. Use a `for` loop to avoid memory allocations:
"""

function integrate!(out, x0, y0, α, β, γ, δ, Δt, nt)
    out[1, :] .= x0, y0
    for it in 2:nt+1
        #hint out[it, 1] = ...
        #hint out[it, 2] = ...
        #sol out[it, 1] = out[it-1, 1] + Δt * dx_dt(out[it-1, 1], out[it-1, 2], α, β)
        #sol out[it, 2] = out[it-1, 2] + Δt * dy_dt(out[it-1, 1], out[it-1, 2], γ, δ)
    end
    t = range(0, nt * Δt, nt + 1)
    return t, out
end

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Solve the same ODEs using the `integrate!` function and time the results:
"""

#hint ## ...
#sol @time t2, out2 = integrate!(out2, x0, y0, α, β, γ, δ, Δt, nt)

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
Make sure that the results are the same:
"""

@assert maximum(abs.(out1 .- out2)) < eps()

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
There is a simple trick to make the solution much more accurate without increasing the resolution too much.

First, revert `nt` to 1000 and re-run the previous simulation.

👉 Next, make a small modification to make the time integration semi-implicit:
"""

function integrate_si!(out, x0, y0, α, β, γ, δ, Δt, nt)
    out[1, :] .= x0, y0
    for it in 2:nt+1
        #hint out[it, 1] = ...
        #sol out[it, 1] = out[it-1, 1] + Δt * dx_dt(out[it-1, 1], out[it-1, 2], α, β)
        ## hint: use the freshly computed value of x from the current time step
        ## and the value of y from the previous time step
        #hint out[it, 2] = ...
        #sol out[it, 2] = out[it-1, 2] + Δt * dy_dt(out[it, 1], out[it-1, 2], γ, δ)
    end
    t = range(0, nt * Δt, nt + 1)
    return t, out
end

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Re-run the code and add another panel with the results:
"""

#hint @time t2, out2 = integrate_si!(...)
#sol @time t2, out2 = integrate_si!(out2, x0, y0, α, β, γ, δ, Δt, nt)

ax2 = Axis(fig[1, 2]; xlabel="time", ylabel="population", title="semi-implicit Euler")
#hint series!(...; labels=["prey", "predator"])
#sol series!(ax2, t2, out2'; labels=["prey", "predator"])
axislegend(ax2)

fig

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Much better, huh? Other way to explore the solutions to ODEs is visualising phase portraits:
"""

ax3 = Axis(fig[2, 1]; xlabel="prey", ylabel="predator")
ax4 = Axis(fig[2, 2]; xlabel="prey", ylabel="predator")

#hint lines!(...)
#hint lines!(...)
#sol lines!(ax3, out1[:, 1], out1[:, 2])
#sol lines!(ax4, out2[:, 1], out2[:, 2])

fig

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Finally, let's benchmark the `integrate_si!` function (hint: use `@benchmark` macro and prepend each argument with '$')
"""
#hint ...
#sol @benchmark integrate!($out2, $x0, $y0, $α, $β, $γ, $δ, $Δt, $nt)
