---
title: "Python Text Adveture: Part 2"
kind: activity
---

### User 2

- Add a `current` read-only [`property`][property] to `World` that
  returns the current Room object.

  - rename the instance variable `self.current` to `self._current`.  The
    underscore is a message to the programmer that this variable should
    be considered private (but remember: Python does not distinguish
    between public/private and so does not protect against miss-use of
    private data).

  - Use the `property` [decorator] on a function with the name `current`
    that simple returns the value of `self._current`

- Add a `go` method to `World` that takes a direction name
  (`north`,`south`, `east` or `west`) as a parameter and, if a path in
  that direction exists from the current room, updates the current room
  to the one in that direction.

  ~~~ python
  class NoPath(RuntimeError):
      pass
      
  class World:
      ...
      def go(self,direction):
          # if a path of 'direction' exists from self.current
              # then set self._current to the room associated with 'direction'
              ...
          # else
              raise NoPath(direction)
  ~~~
  
[decorator]: https://docs.python.org/3/glossary.html#term-decorator
[property]: https://docs.python.org/3/library/functions.html#property

### User 1

Add a simple command parser that can correctly interpret 'go'
commands. You may need to make some changes to the way data is stored
in World or Room to accomodate the requirements of the new
functionality.  When doing so, keep changes as simple as possible and
data as restricted as possible (e.g. the `World.go` method only needs
to know if the direction requested is valid for the current room, it
does not need to know all available directions for the current room).

- split the command string into an `action` and `arguments`.  You can
  use Python's [str.partition] to partition a string by a separator into three
  pieces.

  ~~~~ pycon
  >>> "go north".partition(' ')
  ('go', ' ', 'north')
  >>> "look".partition(' ')
  ('look', '', '')
  ~~~~

  Unlike [str.split], the partition method always returns a 3-tuple,
  even if the string doesn't contain the partition separator, as in
  the `"look"` example above.  This is one way to deal with optional
  arguments without having to worry about `IndexError` or `ValueError`

  ~~~ pycon
  >>> action, arguments = "go north".split()
  >>> # no error, split returned a list of 2 items
  >>> action, arguments = "look".split()
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
    ValueError: need more than 1 value to unpack
  >>> # ValueError because split() returned a list of only 1 item
  ~~~

  We can also unpack the return of [str.partition] into three variables

  ~~~ pycon
  >>> before, sep, after = "a string with several words".partition(' ')
  ~~~

  but if we are never going to use the `sep` variable it's just getting in the way. We can use Python's slicing syntax to retrieve every *other* item from a sequence

  ~~~ pycon
  >>> action, arguments = "go north".partition(' ')[::2]
  ~~~

  The `[::2]` means "pick every other element starting from index 0"
  (the general form looks like `[n::m]` and means "pick every m'th
  element starting from index n. If `n` is omitted, it is assume to be
  0).
  
- we *could* use a dict to simulate a switch/case statement found in
other languages:

  ~~~ python
  ...
  myworld = world.World( ... )

  while True:
      # get cmd_string from user
      ...
      cmd_action = { 'go': World.go, 'look': World.look }

      action, arguments = cmd_string.partition(' ')[::2]

      # call the method associated with the action
      cmd_action[action](arguments)
  ~~~

  But as we discussed this requires that we update the code for our
  command parser *and* the World API whenever we implement a new
  command. Duplicating information in this way should always make you
  think "can I do this in a different way without duplicating
  information".  Depending on the language, it can be tricky to always
  separate knowledge between modules. If we make the rule that all
  command actions will have an API method defined in 'World' with the
  same name, then we can use Python's `getattr` method to return a
  function object associated with an arbitrary action string:

  ~~~ python
  ...
  myworld = world.World( ... )

  while True: # command loop
      # get cmd_string from user
      ...
      action, arguments = cmd_string.partition(' ')[::2]

      # call the method associated with the action
      getattr(myworld, action)(arguments)
  ~~~
  
[str.partition]: https://docs.python.org/3.1/library/stdtypes.html#str.partition
[str.split]: https://docs.python.org/3.1/library/stdtypes.html#str.split
