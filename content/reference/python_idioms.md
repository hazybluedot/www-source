---
title: Common Python Idioms
kind: reference
---

## Transform a list of items from one form to another

Whenever you have something that looks like

~~~ python
collection2 = [] # a new, empty list
for thing in collection1:
    collection2.append( some_function( thing ) )
~~~

you can use list comprehension to write it as

~~~ python
collection2 = [ some_function(thing) for thing in collection1 ]
~~~
