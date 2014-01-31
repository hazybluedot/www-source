---
title:
provides: { background: balanced_brace_algorithm }
---

# Types of balancing errors
1. What are the different types of balancing errors that can occur?

   If we are concerned with only one type of brace, for example `{ }`
   then there are only two types of balancing errors:

   - unmatched opening brace: e.g. `{ a b c { e f } g` is missing a
     closing `}`
   - unmatched closing brace: e.g. `{ a b c { e f } g } }` has an
     extra closing brace.

   If we also consider other types of braced, like `( )` and `[ ]`
   then we have an additional unbalaned condition:

   - mismatched braces/bad nesting: e.g. `{ ( [ ) ] }`

# Data Structures and Algorithms
How would you keep track of the necessary data and what algorithm
would you use if you wanted to
1. Detect balancing errors for only one kind of brace (e.g. `()` is
balanced but `(()` and `())` are not)
2. Detect balancing errors for multiple kinds of braces (e.g. `{ (
[] ) }` is balanced, `{ ([)] }` is not)
3. Detect balancing errors and keep track of what line and column
number the problem occurred.

