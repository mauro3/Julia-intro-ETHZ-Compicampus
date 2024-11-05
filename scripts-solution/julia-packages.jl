using Markdown


md"""
# Modules and packages

Modules can be used to structure code into larger entities, and be used to divide it into
different name spaces.  We will not look into those, but if interested see
[https://docs.julialang.org/en/v1/manual/modules/](https://docs.julialang.org/en/v1/manual/modules/)

**Packages** are the way people distribute code and we'll make use of them extensively.
In the first example, the Lorenz ODE, you saw
```
using GLMakie
```
This statement loads the package `GLMakie`, a plotting package, and makes its functions
and types available in the current session and use it like so:
"""

using GLMakie       # --> this will likely error because GLMakie is not installed!
plot( (1:10).^2 )

md"""
### Packages

All public Julia packages are listed on [https://juliahub.com/ui/Packages](https://juliahub.com/ui/Packages).

Let's install `GLMakie.jl`

- go to the REPL
- hit `]` --> the puts you into the package mode
- `add GLMakie` will add the package
- backspace will get you back to the normal `julia>` prompt

This will take some time...

Try again plotting
"""

using GLMakie
plot( (1:10).^2 )


md"""
### Environments / Projects (those are use quite interchangeably...)

The `GLMakie.jl` package, you installed into the global environment (ok, depending on how you got the files, VSCode may have used the environment defined for this git-repository [https://github.com/mauro3/Julia-intro-ETHZ-Compicampus/blob/main/Project.toml](https://github.com/mauro3/Julia-intro-ETHZ-Compicampus/blob/main/Project.toml)).  In general, it's best to
install most packages into a "environment" which you just use for a particular project.  The
project itself housed within a folder.

To create an environment within VS-Code:
- create a folder in the side bar `TmpProj`
- right click on it in the side bar to:
  - "Julia: Change to this directory"
  - "Julia: Activate this Environment"
- in the REPL hit `]`

Why don't you install `UnPack` in this environment.
- -> note the two files which were created in this folder: this is where Julia stores the
  Information about the Environment


Refs:
- [https://docs.julialang.org/en/v1/manual/code-loading/#Environments](https://docs.julialang.org/en/v1/manual/code-loading/#Environments)
- [https://docs.julialang.org/en/v1/stdlib/Pkg/](https://docs.julialang.org/en/v1/stdlib/Pkg/)
"""
