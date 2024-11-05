#src # This is needed to make this run as normal Julia file:
using Markdown #src
using Markdown #jl


#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
## Plotting with Julia (using GLMmakie.jl)

There are many plotting packages out there.  Maybe the main ones:
- Plots.jl -- the old standard
- Makie.jl -- the new kid on the block

Also, if you come from Python: `PythonPlot.jl` might be good, wrapping matplotlib.
"""

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
Installation: see `julia-packages.jl`

Simple plots
- `plot` tries to plot the right thing
"""
using GLMakie

plot(1:3)  # a scatter plot, for a line use `line`
A = rand(50,50);
#hint ...  ## try heatmap
#sol heatmap(A)  #


#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
The docs are [https://docs.makie.org/stable](https://docs.makie.org/stable/)
"""

# Plot two plots into one figure
f = Figure()
scatter(f[1, 1], rand(100, 2))
lines(f[1, 2], cumsum(randn(100)))

