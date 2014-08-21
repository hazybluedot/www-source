---
title: "More Python OOP: Designing APIs"
kind: activity
---


- no 'getters' or 'setters', just access the attributes directly

  ~~~ python
  print(world.current)
  ~~~

  not

  ~~~ python
  print(world.get_current())
  ~~~
     
- no private/public distinction, all methods and variables are accessible by the outside
  - by convention, methods and variables staring with '_' are meant to
    be private.  The language does not inforce access control, the
    naming convention aids developers.

- If you need to add logic to the getter/setter, use a [`property`](https://docs.python.org/3/library/functions.html#property)

  ~~~ python
  class MyClass:
     def __init__(self):
         self._my_attr = 42
     ...
     @property
     def my_attr(self):
         return self._my_attr

     @my_attr.setter
     def my_attr(self, value):
         self._my_attr = value
  ~~~

## Defining an API for World

- Need a way of accessing the "current" room
- Need a way to "go" in a particular direction, changing the current room.
