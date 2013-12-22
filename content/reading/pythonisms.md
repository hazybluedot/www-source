---
title: Pythonisms
---

# Contents
{:.no_toc}

* Table of Contents
{:toc}

## What is Pythonic?

Python is a flexible language designed to meet every day general
purpose programming needs.  You *could* use it much the same way you
would us C or C++ but if you stopped there then why not just use C or
C++ in the first place?

## Generators

For now see
[this section](/reading/record_jar/#generators-and-the-yield-keyword)
in the record jar reading.

## List Comprehension

[Section 3.3](http://www.diveinto.org/python3/comprehensions.html#listcomprehension) of [Dive Into Python 3](http://www.diveinto.org/python3/)

An example:

~~~~ python
planets = [ Planet(planet) for planet in rjr.record_reader(sys.stdin) ]
~~~~

will iterate over the items returned by the generator
`rjr.record_reader(sys.stdin)`, passing each item to the constructor
of the `Planet` class and append the resulting `Planet` object in a
new list which is stored in the `planets` variable.  Without list
comprehension this same process would look like

~~~~ python
planets = []
for planet in rjr.record_reader(sys.stdin):
    planets.append(Planet(planet))
~~~~

Using a list comprehension saved use 2 lines of code and is much
easier to read (once we learn the basics of the list comprehension
syntax) and quickly determine what is going on.

### Returning a generator instead of a list

Worried about storing huge lists in memory just for the benefit of the
list comprehension syntax? Don't be: replacing the square brackets
`[]` with parenthesis `()` in the list comprehension will return a
generator instead of a list.

~~~~ python
planets = ( Planet(planet) for planet in rjr.record_reader(sys.stdin) )
~~~~

Now `planets` is a generator, every time its `__next__` function is
called it retrieves the next item from the `record_reader` generator,
creates a `Planet` object and returns it, so now you can happily read
in a file containing a ridiculously long list of planet records
without worrying about memory usage.

## Exception Handling

This is one area where there are some strong negative oppinions about
the 'Pythonic' way to do things. Python favors using exception
handling (`try`/`execept`) blocks as a way of flow control. For instance, rather than

~~~~ python
if index < len(my_list):
    x = my_list[index]
else:
    x = 'NO_ABC'
~~~~

you would write

~~~~ python
try:
    x = my_list[index]
except IndexError:
    x = 'NO_ABC'
~~~~

see the response to
[this stackoverflow question](http://stackoverflow.com/questions/7604636/better-to-try-something-and-catch-the-exception-or-test-if-its-possible-first)
for an explination.
