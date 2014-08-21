---
title: "Python Text Adventure: Part 1"
kind: activity
#tests:
#  - type: bonair
#    feature: features/pytxt
#    tags: [ part1 ]
#  - type: python-unittest
#    tests: pyutest/pytxt
repo:
  - user: USER/pytxt
---

## Preamble

Use the files at `/usr/share/txtadventure/` on the ece2524 VM and the
copies you have been working on as a reference, but create *new* files
in a *new* repository for this project to avoid complicated merge
conflicts when you work with a partner.

Avoid copying and pasting the commands and code snippets I list
here. Type them in and think about what each one does. Think about the
steps each user completes and how they generalize to other
collaborative projects.  You will be following a similar procedure
when collaborating for your final project.

## Initialization

Pick someone to be `user1` and someone to be `user2`.  The
initilization steps will vary depending on your role:

 - `user1` will initialize a repository and push it to a remote location
 - `user2` will fork the repo that `user1` pushed and clone a local copy

### User 1

  1. Initialize a new repository

     ~~~ console
     $ git init ~/ece2524/pytxt
     $ cd ~/ece2524/pytxt
     ~~~
     {:.command-syntax .no-explain}

  2. Add initial files

     world.py:

     ~~~~ python
     class Room:
         """A single room"""

         def __init__(self, data):
             self.description = data['desc']
             self.items = data['items']

         def __str__(self):
             return self.description + "\nitems: " +  ", ".join(self.items)

     class World:
         """A world contains one or more rooms"""

         def __init__(self, data, current_name):
             self.rooms = {}
             for key,value in data.items():
                 self.rooms[key] = Room(data[key])

             self.current = self.rooms[current_name]

         def __str__(self):
             return "World:\n{0}".format( "\n%%\n".join(
                 [ name + ": " + str(room) for name,room in self.rooms.items() ]
             ) )
     ~~~~
    
     <!-- [[git:impl/pytxt:06a5838:world.py]] -->

     And a file `game.py` that

     - imports the `world` and `yaml` modules

     - loads yaml file `rooms.yaml`

       ~~~~ python
       data = yaml.load( open('rooms.yaml', 'r') )
       ~~~~

     - creates a World object with the loaded data
       
       ~~~~ python
       myworld = world.World( data, 'SURGE 104C' )
       ~~~~

       The fact that we have to initialize the current room
       this way is not ideal, why not? What are some possible
       solutons? Let's discuss them on Wednesday.

     - prints the World object

     Ensure that `game.py` has an appropriate [shebang] line and has [execute permission][man:chmod].
     
  3. Add a remote

     ~~~~ console
     $ git remote add origin <%= config[:git_url]%>:<user1>/pytxt.git
     ~~~~
     {:.command-syntax .no-explain}

  4. Make initial push

     ~~~~ console
     $ git push -u origin master
     ~~~~
     {:.no-explain}

  5. Give read access to `user2`

     ~~~~ console
     $ ssh <%= config[:git_url]%> perms <user1>/pytxt + READERS <user2>
     ~~~~
     {:.command-syntax .no-explain}

[shebang]: http://en.wikipedia.org/wiki/Shebang_%28Unix%29
[man:chmod]: http://linux.die.net/man/1/chmod

### User 2

  1. Fork `user1/pytxt`

     ~~~~ console
     $ ssh <%= config[:git_url]%> fork <user1>/pytxt <user2>/forks/pytxt
     ~~~~
     {:.no-explain .command-syntax}

  2. Give `user1` read access to your fork

     ~~~~ console
     $ ssh <%= config[:git_url]%> perms <user2>/forks/pytxt + READERS <user1>
     ~~~~
     {:.command-syntax .no-explain}

  2. Clone your forked copy

     ~~~~ console
     $ git clone <%= config[:git_url]%>:<user2>/forks/pytxt.git ~/ece2524/pytxt
     ~~~~
     {:.command-syntax .no-explain}

  3. Modify `world.py`
  
     - Define a new `Item` class. This should be a very simple class with a single instance variable containing the name of the item.  Something like

       ~~~~ python
       class Item:
           def __init__(self, name):
               self.name = name

           def __str__(self):
               return self.name
       ~~~~

     - Update the `Room.__init__` method to populate an instance
     variable with a list of items wrapped in the `Item` class. Use
     the code in `World` that generates a `dict` of `Room` as a
     reference, though note that you will be creating a list, not a
     dict.  `data['items']` is a list of strings, so

       ~~~ python
       for item in data['items']:
           # do something with item, which is a string
       ~~~

       would iterate over that list.  For each thing in that list,
       create an `Item` object and [append] it to a list. Set
       `self.items` to that list.  This an be done
       [in a single line][transform_idiom] using [list comprehension]
     

     - You will also have to modify the `Room.__str__` method since
       items is now a list of `Item` objects and not a list of
       strings. `str.join` expects a list of strings, but `self.items`
       is now a list of `Item` objects. You will need to transform the
       list of Items into a list of strings. This can be done with [a
       single][transform_idiom] [list comprehension]:

       ~~~~ python
       ...
       list_of_strings = [ str(item) for item in self.items ]
       ...
       ~~~~

  4. Create a Python program in a file named `test.py` that confirms that items are wrapped in the `Item` class:

     - initialize a `World` object following the same procedure used in `game.py`
     - loop through each room in your created world object
     - loop through each item in the room and check that it
       [is an instance](https://docs.python.org/3.1/library/functions.html#isinstance)
       of `Item`.[^isinstance]
     - don't print any output, but [raise] a
       [`RuntimeError`][RuntimeError] if any of the items are not
       instances of `world.Item`

  5. Add and commit your changes and push to your own remote. Notify
     `user1` so that they can pull and merge your additions.

  6. Add a remote named `upstream` for easy merges from `user1` in the future

     ~~~~ console
     $ git remote add upstream <%= config[:git_url]%>:<user1>/pytxt.git
     ~~~~
     {:.command-syntax .no-explain}

[RuntimeError]: https://docs.python.org/3.3/library/exceptions.html#RuntimeError
[raise]: https://docs.python.org/3.3/reference/simple_stmts.html#raise
[append]: https://docs.python.org/3.3/tutorial/datastructures.html
[list comprehension]: https://docs.python.org/3.1/tutorial/datastructures.html#list-comprehensions
[transform_idiom]: /reference/python_idioms/#transform-a-list-of-items-from-one-form-to-another

### User 1

  1. Add a remote named as `user2`'s username for easy merges:

     ~~~~ console
     $ git remote add <user2> <%= config[:git_url]%>:<user2>/forks/pytxt.git
     ~~~~
     {:.command-syntax .no-explain}
     
  2. When you receive notification from `user2`, pull and merge their changes.

     ~~~~ console
     $ git pull <user2> master
     ~~~~
     {:.command-syntax .no-explain}
     
[^isinstance]:

    Note that except in very specific cases such as this one,
    [you should avoid using Python's isinstance() method][isinstance_harmful]. Once
    we clarify what the `Item` class should provide, a better check
    would be to use [hasattr] to check for interface support,
    regardless of type.

[isinstance_harmful]: http://www.canonical.org/~kragen/isinstance/
[hasattr]: https://docs.python.org/3.1/library/functions.html#hasattr

  
## Testing

I am in the process of writing up automated tests for this
assignment. You should always conduct your own tests to confirm your
program works according to the specifications. This will provide
helpful context and understanding if your program does pass some of
the automated tests once they get posted!

Update: I've spent more time than anticipated addressing questions and
adding to the write-up and I won't be able to get tests posted before
the deadline.  Just do the best you can with the specs as is and your
own testing.
