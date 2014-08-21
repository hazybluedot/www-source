---
title: "Object Oriented Python: dict to World object"
kind: activity
---


- Review code in `/usr/share/textadventure`. Copy all `*.py` files and
  `rooms.yaml` into an empty directory in your home directory.  Change
  to that directory and start the python interpreter.  Run the
  following commands and observe the output.

~~~~ pycon
>>> import game_helper as gh
>>> data = gh.load_yaml('rooms.yaml')
>>> print(type(data))
>>> print(data)
>>> world = gh.World( data )
>>> print(type(world))
>>> print(world)
~~~~

The builtin function `type` returns the type of object of whatever is
passed in as an argument. What is the type of `data` and what is the
type of `world`?


1. Write a Python program that executes the lines above. Set the
   permission of the file to allow execution and add an appropriate
   shebang line. This will make it easier to evaluate changes you make
   to the modules (you would need to quit and restart the interpreter
   each time to load changes made to imported modules).

2. What is the purpose of the `__str__` method in each of the classes
   defined in `world.py`? Try changing the string returned in those
   methods and then run the previous commands again.
 

3. Write an `Item` class, modify the `Room` class to store an instance
   vairable `self.items` and populate the list with `Item` objects,
   similar to how `World` populates a list of `Rooms`.
