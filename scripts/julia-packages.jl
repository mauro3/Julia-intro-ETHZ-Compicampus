using Markdown


md"""
# Modules and packages

Modules can be used to structure code into larger entities, and be used to divide it into
different name spaces.  We will not look into those, but if interested see
[https://docs.julialang.org/en/v1/manual/modules/](https://docs.julialang.org/en/v1/manual/modules/)

**Packages** are the way people distribute code and we'll make use of them extensively.
In the first example, the Lorenz ODE, you saw
```
using Plots
```
This statement loads the package `Plots` and makes its functions
and types available in the current session and use it like so:
"""

using Plots       # --> this will likely error because Plots is not installed!
plot( (1:10).^2 )

md"""
### Packages

All public Julia packages are listed on [https://juliahub.com/ui/Packages](https://juliahub.com/ui/Packages).

Let's install `Plots.jl`

- go to the REPL
- hit `]` --> the puts you into the package mode
- `add Plots` will add the package
- backspace will get you back to the normal `julia>` prompt

This will take some time...

Try again plotting
"""

using ...
plot( (1:10).^2 )


md"""
### Environments / Projects (those are use quite interchangeably...)

The `Plots.jl` package, you installed into the global environment.  In general, it's best to
install most packages into a "environment" which you just use for a particular project.  The
project itself housed within a folder.

To create an environment within VS-Code:
- create a folder in the side bar `TmpProj`
- right click on it in the side bar to:
  - "Julia: Change to this directory"
  - "Julia: Activate this Environment"
- in the REPL hit `[`

Why don't you install `UnPack` in this environment.
- -> note the two files which were created in this folder: this is where Julia stores the
  Information about the Environment


Refs:
- [https://docs.julialang.org/en/v1/manual/code-loading/#Environments](https://docs.julialang.org/en/v1/manual/code-loading/#Environments)
- [https://docs.julialang.org/en/v1/stdlib/Pkg/](https://docs.julialang.org/en/v1/stdlib/Pkg/)
"""
