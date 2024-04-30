using Markdown


md"""
# Plotting with Julia (using Plots.jl)

There are many plotting packages out there.  Maybe the main ones:
- Plots.jl -- the old standard
- Makie.jl -- the new kid on the block

Also, if you come from Python: `PythonPlot.jl` might be good, wrapping matplotlib.
"""

md"""
Installation: see `julia-packages.jl`

Simple plots
- `plot` tries to plot the right thing
"""
using Plots

plot(1:3)  # a line
A = rand(50,50);
...  ## try heatmap


md"""
The docs are [https://docs.juliaplots.org/stable/](https://docs.juliaplots.org/stable/)

Important:
- [basics](https://docs.juliaplots.org/stable/basics/)
- [layouts](https://docs.juliaplots.org/stable/layouts/)
- [attributes](https://docs.juliaplots.org/stable/attributes/) (this I usually have open and search for stuff)
"""

plot(plot(1:3),
     plot(rand(5,6))
     )

# check `layout` attribute and make a figure of a 4x4 plots
