using Markdown


md"""
# Plotting with Julia (using GLMmakie.jl)

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
using GLMakie

plot(1:3)  # a scatter plot, for a line use `line`
A = rand(50, 50);
...  ## try heatmap


md"""
The docs are [https://docs.makie.org/stable](https://docs.makie.org/stable/)
"""

f = Figure()
scatter(f[1, 1], rand(100, 2))
lines(f[1, 2], cumsum(randn(100)))

ax = Axis(f[2, 1]; xlabel="x", ylabel="y", title="subplot")
lines!(ax, cumsum(randn(20)); label="line", linewidth=3, color=:red)
scatter!(ax, cumsum(randn(20)); label="scatter", marker=:cross, markersize=rand(5:20, 20))
axislegend(ax)
