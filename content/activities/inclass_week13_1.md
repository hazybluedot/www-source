---
title: "Final Word Count, Plan for PyAdventure"
kind: activity
---


## From last class

- [What is the difference between a list and tuple in Python?](http://stackoverflow.com/questions/626759/whats-the-difference-between-list-and-tuples-in-python)

  - While the language does not inforce lists to be homogeneous, it is
  generally a good idea to use them as such
  - tuples are immutable

    ~~~~ pycon
    >>> mytuple = ( 1, 'one' )
    >>> mytuple[1]
    one
    >>> mytuple[1] = 'two'
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: 'tuple' object does not support item assignment
    ~~~~

## Sorted Dictionaries

- `sorted`
- key functions

## Elements of a text-based game

- Game data stored on disk
- Load data from disk to memory
- Manipulate in-memory data based on user actions
- Write data back to disk

## Representing an Environment

![simple map of surge](/assets/images/game_map.svg)

- record-jar

  [[snippet:files/rooms.rjar]]

  Using a
  [record-jar parser I wrote](/reading/record_jar/index.html#as-a-module)
  we can load this file into Python:

  ~~~~ pycon
  >>> from record_jar_reader import load_records
  >>> rooms = load_records( open('rooms.rjar', 'r') )
  >>> from pprint import pprint #to pretty-print Python objects
  >>> pprint(rooms)
  [{'description': 'a generic classroom',
    'items': 'desk,chalk,a mysterious note',
    'name': 'SURGE 104C',
    'north': 'SURGE Study Area'},
   {'description': 'an open space',
    'items': 'vending machine',
    'name': 'SURGE Study Area',
    'south': 'SURGE 104C'}]
  >>>
  ~~~~

  Notice, we get a [`list`][docs.python:list] of [`dicts`][docs.python:dict]. If we wanted to print a list of
  room names we would have to iterate over the items in the list and
  retreive the 'name' field of each.

  ~~~~ pycon
  >>> for room in rooms:
  ...     print(room['name'])
  ...
  SURGE 104C
  SURGE Study Area
  >>>
  ~~~~

  The cleanest way to obtain a [`list`][docs.python:list] of room names is with list comprehension:

  ~~~~ pycon
  >>> names = [ room['name'] for room in rooms ]
  >>> print(names)
  ['SURGE 104C', 'SURGE Study Area']
  >>>
  ~~~~

  A more traditional `for` loop to do the same thing would look like

  ~~~~ pycon
  >>> names = []
  >>> for room in rooms:
  ...     names.append(room['name'])
  ...
  >>> print(names)
  ~~~~

- YAML

  [[snippet:files/rooms.yaml]]
  
  Assuming we write the description to a file named `rooms.yaml`:

  ~~~~ pycon
  >>> import yaml
  >>> rooms = yaml.load( open('rooms.yaml', 'r') )
  >>> rooms
  {'SURGE 104C': {'desc': 'a generic classroom',
    'items': ['desk', 'chalk', 'a mysterious note'],
    'north': 'SURGE Study Area'},
   'SURGE Study Area': {'desc': 'an open space',
    'items': ['vending machine'],
    'south': 'SURGE 104C'}}
  ~~~~

  Now we get a `dict` in which the keys are the names of the rooms and
  the values are each a `dict` with key/value pairs for the keys
  "desc", "items", etc.

  This representation is convenient to get a list of rooms:

  ~~~~ pycon
  >>> rooms.keys()
  ~~~~

  Or obtain the list of items in a particular room
  
  ~~~ pycon
  >>> rooms['SURGE 104C']['items']
  ~~~

- JSON

  If we have a file `rooms.yaml` already, let's not make our life any
  harder. Use Python to convert from one format to another:

  ~~~~ pycon
  >>> import yaml
  >>> import json
  >>> rooms = yaml.load( open('rooms.yaml') )
  >>> with open('rooms.json', 'w') as fp:
  ...    json.dump(rooms, fp, indent=4, separators=(',', ':'))
  ~~~~

  Results in a file named 'rooms.json' with

  [[snippet:files/rooms.json]]
  
  Note, if we didn't care about readability of the text file we could have omitted the `indent` and `separators` parameters to the `json.dump` call resulting in a file with

  [[snippet:files/rooms_inline.json]]

[docs.python:dict]: https://docs.python.org/3.3/library/stdtypes.html#mapping-types-dict
[docs.python:list]: https://docs.python.org/3.3/library/stdtypes.html#list

## Zork

A [web-based port](http://thcnet.net/zork) of
[Zork](http://en.wikipedia.org/wiki/Zork) is available. Give it a
spin.
