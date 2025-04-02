#src # This is needed to make this run as normal Julia file:
using Markdown #src
using Markdown #jl

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
###  Let's get our hands dirty!

We will now look at
- variables and types
- control flow
- functions
- modules and packages
"""

md"""
The documentation of Julia is good and can be found at [https://docs.julialang.org](https://docs.julialang.org); although for learning it might be a bit terse...

There are also tutorials, see [https://julialang.org/learning/](https://julialang.org/learning/).

Furthermore, documentation can be gotten with `?xyz`.  Try it (in Jupyter notebooks this needs to be in a cell of its own):
"""

## ?cos

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
## Variables, assignments, and types [5min]
[https://docs.julialang.org/en/v1/manual/variables/](https://docs.julialang.org/en/v1/manual/variables/)
"""

a = 4
b = "a string"
c = b # now b and c bind to the same value

md"""
Conventions:
- variables are (usually) lowercase, words can be separated by `_`
- function names are lowercase
- modules, packages and types are in CamelCase
"""

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### Variables: Unicode
From [https://docs.julialang.org/en/v1/manual/variables/](https://docs.julialang.org/en/v1/manual/variables/):

Unicode names (in UTF-8 encoding) are allowed and typed in LaTeX notation.  Try making a variable
- `δ = 99` with `\delta`+tab
- `x² = 25` with `x\^2`+tab
"""

#hint ##
#sol δ = 99
#sol x² = 25

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### Basic datatypes
- numbers (Ints, Floats, Complex, etc.)
- strings
- tuples
- arrays
- dictionaries
"""

1     # 64 bit integer (or 32 bit if on a 32-bit OS)
1.5   # Float64
1//2  # Rational
#-
typeof(1.5)
#-
"a string", (1, 3.5) # and tuple
#-
[1, 2, 3,] # array of eltype Int
#-
Dict("a"=>1, "b"=>cos)


#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
## Array exercises [3min]

Arrays are the bread and butter of science...

- indexing starts at 1
- uses `[]`
- in Julia they are column-major (like in Matlab, unlike Python)
"""

# Task: assign vectors to `a`, and `b` and the concatenate them using `;`:

a = [2, 3]
#hint b = ...
#hint [ ; ]
#sol b = [4, 5]
#sol [a ; b]

# Add new elements to the end of Vector `b` (hint look up the documentation for `push!`)

#hint ## ?push!
#sol push!(b, 1)
#sol push!(b, 3, 4)

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Side note: the !-notation

By convention, functions named ending with `!` are mutating functions.

Thus `push!(A, 4)` will update `A` to contain also the element `4`.

Note that the `!` is just part of the name, it's not special syntax (unlike the `.` which you'll
encounter further down)
"""


#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Array exercise: indexing

Access element `[1,2]` and `[2,1]` of Matrix `a` (hint use []):
"""

a = rand(3,4)
#hint a[ ... ], a[ ... ]
#sol a[1,2], a[2,1]

# Linear vs Cartesian indexing,
# access the first element:

a[1]
a[1,1]

# Access the last element (look up `?end`) both with linear and Cartesian indices

#hint a[...]
#hint a[..., ...]
#sol a[end]
#sol a[end, end]

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Array exercise: indexing by ranges

Access the last row of `a` (hint use `1:end`)
"""

#hint a[... , ...]
#sol a[end, 1:end]

# Access a 2x2 sub-matrix

#hint a[ ]
#sol a[1:2, 1:2]

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### A small detour: types

All values have types.  Arrays store in their type what type the elements can be.

> Arrays which have concrete element-types are more performant!
"""
typeof([1, 2]), typeof([1.0, 2.0])

# Aside, they also store their dimension in the second parameter.
#
# The type can be specified at creation
String["one", "two"]

# Create an array taking `Int` with no elements.  Push `1`, `1.0` and `1.5` to it.  What happens?

#hint ##
#sol a = Int[]
#sol push!(a, 1) ## works
#sol push!(a, 1.0) ## works
#sol # push!(a, 1.5) ## would error as 1.5 cannot be converted to an Int

#-
# Make an array of type `Any` (which can store any value).  Push a value of type
# Int and one of type String to it.

#hint ##
#sol a = []
#sol push!(a, 5)
#sol push!(a, "a")



#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
## Control flow

Julia provides a variety of [control flow constructs](https://docs.julialang.org/en/v1/manual/control-flow/), of which we look at:

  * [Conditional Evaluation](https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation): `if`-`elseif`-`else` and `?:` (ternary operator).
  * [Short-Circuit Evaluation](https://docs.julialang.org/en/v1/manual/control-flow/#Short-Circuit-Evaluation): logical operators `&&` (“and”) and `||` (“or”), and also chained comparisons.
  * [Repeated Evaluation: Loops](https://docs.julialang.org/en/v1/manual/control-flow/#man-loops): `while` and `for`.
"""

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### Conditional evaluation
[https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation](https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation)

if-blocks
"""
a = 77
if a==45
    println("Hi")
elseif a==77
    println("Hello")
else
    println("Grüss Gott")
end

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Conditional evaluation: the "ternary operator" `?`
"""
a = 1
a > 5 ? "really big" : "not so big"

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### Short circuit operators `&&` and `||`

[https://docs.julialang.org/en/v1/manual/control-flow/#Short-Circuit-Evaluation](https://docs.julialang.org/en/v1/manual/control-flow/#Short-Circuit-Evaluation)

Relatively often used in Julia:
```
a < 0 && error("Not valid input for `a`")
```
"""

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
### Loops: `for` and `while`

[https://docs.julialang.org/en/v1/manual/control-flow/#man-loops](https://docs.julialang.org/en/v1/manual/control-flow/#man-loops)
"""

for i = 1:3
    println(i)
end

for i in ["dog", "cat"] ## `in` and `=` are equivalent for writing loops
    println(i)
end

i = 1
while i<4
    println(i)
    i += 1
end


#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "slide"}}
md"""
## Functions

Functions can be defined in Julia in a number of ways.  In particular there is one variant
more suited to longer definitions, and one for one-liners:

```
function f(a, b)
   return a * b
end
f(a, b) = a * b
```

Defining many, short functions is typical in good Julia code.

See [https://docs.julialang.org/en/v1/manual/functions/](https://docs.julialang.org/en/v1/manual/functions/)
"""

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Functions: exercises [5min]

Define a function `fn` in long-form which takes two arguments and multiplies them
"""

#hint ##
#sol function fn(a, b)
#sol     return a*b
#sol end

## it should pass this thest
a, b = rand(4,5), 7
@assert fn(a,b) == a*b


#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Side note: macros `@`

The `@assert` is a macro call.  Macros take code and return new code which is then executed.
For you as a user these are pretty intuitive to use and are indeed often used in Julia.
Defining them is beyond the scope of this short course
"""



#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Functions: dot-syntax *IMPORTANT*

Functions which are scalar functions in maths, say `cos`, are only defined for scalars in Julia!

To apply them element-wise to vectors use `cos.([1,2])`.

Similarly the dot also works for infix functions, say `.+`.

Exercise: apply the `sin` function to a vector `1:10` and add `7`:
"""

#hint ##
#sol sin.(1:10) .+ 7

# Broadcasting will extend row and column vectors into a matrix.
# Try `(1:10) .+ (1:10)'`  (Note the `'`, this is the transpose operator)

#hint ##
#sol (1:10) .+ (1:10)'

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Functions: dot-syntax exercise

Evaluate the function `sin(x) + cos(y)` for
`x = 0:0.1:pi` and `y = -pi:0.1:pi`.  Remember to use `'` to broadcast to a matrix.
"""

#hint ##
#sol x,y = 0:0.1:pi, -pi:0.1:pi
#sol sin.(x) .+ cos.(y')

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Functions: anonymous functions

So far our function got a name with the definition. They can also be defined without name.

See [https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions](https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions)
"""

map(x -> sin(x) + cos(x), 1:10)

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Key feature: multiple dispatch functions

- Julia is not an object oriented language

OO:
- methods belong to objects
- method is selected based on first argument (e.g. `self` in Python)

Multiple dispatch:
- methods are separate from objects
- are selected based on all arguments
- similar to overloading but method selection occurs at runtime and not compile-time (see also video below)
> very natural for mathematical programming

JuliaCon 2019 presentation on the subject by Stefan Karpinski
(co-creator of Julia):

["The Unreasonable Effectiveness of Multiple Dispatch"](https://www.youtube.com/watch?v=kc9HwsxE1OY)
"""

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
## Functions: Multiple dispatch demo
"""

struct Rock end
struct Paper end
struct Scissors end
### of course structs could have fields as well
## struct Rock
##     color
##     name::String
##     density::Float64
## end

## define multi-method
play(::Rock, ::Paper) = "Paper wins"
play(::Rock, ::Scissors) = "Rock wins"
play(::Scissors, ::Paper) = "Scissors wins"
play(a, b) = play(b, a) # commutative

play(Scissors(), Rock())

#src #########################################################################
#nb # %% A slide [markdown] {"slideshow": {"slide_type": "subslide"}}
md"""
### Multiple dispatch demo
Can easily be extended later

with new type:
"""
struct Pond end
play(::Rock, ::Pond) = "Pond wins"
play(::Paper, ::Pond) = "Paper wins"
play(::Scissors, ::Pond) = "Pond wins"

play(Scissors(), Pond())
#-

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
with new function:
"""
combine(::Rock, ::Paper) = "Paperweight"
combine(::Paper, ::Scissors) = "Two pieces of papers"
## ...

combine(Rock(), Paper())

#nb # %% A slide [markdown] {"slideshow": {"slide_type": "fragment"}}
md"""
*Multiple dispatch makes Julia packages very composable!*

This is a key characteristic of the Julia package ecosystem.
"""
