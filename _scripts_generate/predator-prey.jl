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

<img src="./figures/l1_predator-prey.png" alt="predator-prey" width="80%"/>
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### Tasks

1. Implement the right-hand side of Lotka-Volterra system inside the functions `d🐰_dt`, `d🦊_dt`, and `predator_prey` in the file `src/PredatorPrey.jl`

> Comment out the remaining functions in the file `src/PredatorPrey.jl` so that the module compiles

2. Open `scripts/main.jl` and implement the time integration loop within the file
    1. Measure the execution time with the `@time` macro
    2. Experiment with the time step by changing `nt`, see how the solution changes with decreasing `Δt`

    > The implementation is very similar to the one for the Lorenz attractor from the introduction
"""

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
3. Implement non-allocating version of the time integration in the function `integrate!` in the file `src/PredatorPrey.jl`
    1. Split the line within the time loop into two, updating the population of each species independently
    2. Call `integrate!` from the main script, time the results with the `@time` macro, compare to the execution time in the global scope
    3. Replace `out[it-1, 1]` with `out[it, 1]` in the second line (update rule for `out[it, 2]`) to make the integration semi-implicit

## Resources
Read the [performance tips](https://docs.julialang.org/en/v1/manual/performance-tips/#man-performance-tips)!
"""
