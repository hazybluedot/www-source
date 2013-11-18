---
title: Collections of Things and the Pythonic Way
kind: background
---

## Background

1. [Ranged Loops](/reading/ranged_loops/index.html)

## Collections

Like operating systems, many programming languages have a unifying
concept that influence many aspects of the syntax and the style of
programming used to solve problems. z

As we've discussed before, a computer's strength lies in its ability
to execute repetitive tasks. The 'task' is some kind of computation
and it is often performed repeatedly on different input. Python takes
this assumption to heart and makes it ridiculously easy to do
/something/ to each /thing/ in a collection of /things/. I am being
intentionally abstract here so as to avoid using words like `list`
which refer to a specific data type, though of course a `list` is an
example of a collection of things that can be iterated over:

~~~~ python
primes = [ 2, 3, 5, 7, 11 ] # the first five primes

for prime in primes:
    print(prime)
~~~~

Here I initialize a `list` containing the first 5 prime numbers, then
print each one out in a ranged loop. Notice there is no index variable
and I didn't need to provide an explicit stop condition on the loop.
They Python interpreter knows how many thing are in the `list` named
`primes`. 

Notice I did not have to declare a type for `primes`.  Python knows I
am created a list because of the `[` and `]`, and it infers the type
based on what I put in the list, in this case, integers.

What observations can you make between the Python example above and
the [`C` version](/reading/ranged_loops/index.html#implementing-loops-in-c)?

We can extend the idea of iterating over a collection of things to
data other than lists. For instance, since it is so common to read
text data by the line, Python assumes that data is a collection of
lines

~~~~ python
import sys

for line in sys.stdin:
    print(line)
~~~~

Note that `line` is just an arbitrary name that I chose. You can name
the loop variable anything you wish.

