#src # This is needed to make this run as normal Julia file:
using Markdown #src

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
# 🔨 Hands-on II: implementing predator-prey model

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
# Lotka-Volterra model

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
