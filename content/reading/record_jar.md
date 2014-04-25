---
title: Parsing Record Jar Formatted Files
---

## Record Jar

The
[record-jar](http://www.catb.org/esr/writings/taoup/html/ch05s02.html#id2906931)
format is useful for storing multiple records containing name/value
pairs. The example given in TAOUP will serve us well:

<%= code_snippet('files/planets.records') %>

Individual records are separated by a single line containing `%%`,
each record contains several name/value pairs. Depending on the
specific application some or all names may be required, or some may be
optional.)

Here's one way to read records into a python `dict`:

<%= code_snippet('record-jar/rjar_reader.py') %>

<%= shell_transcript(['record-jar/rjar_reader.py <files/planets.records']) %>

~~~~ console
 $ record-jar/rjar_reader.py <files/planets.records
 Mercury has an orbital radius of 57,910,000 km
 Venus has an orbital radius of 108,200,000 km
 Earth has an orbital radius of 149,600,000 km
~~~~

Looking at the `__main__` function, is it clear what the purpose of
the program is? Not really:

- parsing logic is intermingled with high level program logic (print information for each planet)
- number of visible lines is different from the number of loop
  iterations. We need to mentally parse through the loop logic to
  determine when we actually get a planet object

## Generators and the `yield` keyword

A
[generator](http://en.wikipedia.org/wiki/Generator_(computer_science))
is a type of routine that can be used to easily implement complex
iterators that can be used in loops.  Python's `yield` keyword makes
it ridiculously easy to write generators but keep in mind this is an
abstract programming concept that can be implemented in most other
common programming languages,
[including C++](http://stackoverflow.com/questions/9059187/equivalent-c-to-python-generator-pattern).

[[snippet:record-jar/planet_reader.py]]

The `yield` keyword works kind of like `return` in that at that point
in the code the current value stored in `planet` is returned and the
control returns to the calling function. The difference is that on
subsequent calls to the `planet_reader` generator control picks up at
the line immediately after the `yield` that ended control last time.

If we look closely we'll
note that other than the names we use for variables the function
`planet_reader` doesn't contain any code specific to the data content
but rather will work for ANY data stored in the record-jar format.

## As a module

Let's separate the record-jar parsing code from the specifics of the
planet content so that we can re-use our parser for any data in the
record-jar format.

[[snippet:record-jar/record_jar_reader.py]]

Note I include a simple `__main__` function to test the functionality
of the record-jar reader that does not depend on any particular data
being in the records.  If I invoke `record_jar_reader.py` from the
command line, the code block contained in `__main__` will run, but if
I `import` the file as a module this block will not run. This is
useful for providing test code for modules that you write.

<%= code_snippet('record-jar/planets.py') %>

~~~~ console
 $ record-jar/planets.py <files/planets.records
 Mercury has an orbital radius of 57,910,000 km
 Venus has an orbital radius of 108,200,000 km
 Earth has an orbital radius of 149,600,000 km
~~~~

