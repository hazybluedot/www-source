---
title: "Advanced String Parsing"
activity: reading
---

Consider the text-based adventure game we have been working on.  We
have written a simple command parser that accepts commands such as

~~~~
> go north
> look
~~~~

and laid down the framework for handling things like

~~~~
> pickup lamp
> fight monster
~~~~

as long as we write appropriate methods in our World API. We can do a
lot with just this simple command structure of

~~~
command [argument]
~~~

where the `[` `]` means that parameter is optional. To handle commands
of this form our parser simply needs to partition the full string on
the first space.  What if we wanted to allow more complex grammar in our commands:

~~~
> fight monster with sword
> unlock hatch with key
> throw rock at window
~~~

or commands that act on object groups

~~~
> pickup lamp and key
> pickup lamp, key and mysterious note
> drop 3 candles
~~~

allowing commands like this would provide a much richer experience for
the user but require more complex rules for parsing command strings.

a bad brute-force implementation might look something like

~~~ python
if command == 'pickup':
    if ',' in argument:
        arguments = argument.split(',')
    else:
        arguments = [ argument ] # a list of one item
    counted_arguments = []
    for argument in arguments:
        if re.match('[0-9]+ [a-z]+'):
            number, obj = argument.split(' ')
        else:
            number, obj = 1, argument
        counted_arguments.append( (number, obj) )
if command == 'unlock':
    ...
    if 'with' in argument:
        ...
~~~

as you can see, this will get quite complex, will be prone to human
error, and depends on precise knowledge of all commands.  We could
decouple some of this knowledge if we allowed our parser to generalize
and handle things that might not make sense, but are grammatically
correct

~~~
> pickup lamp on key
> unlock door with 3 keys
~~~

and leave it to the game logic do determine what unlocking a door with
3 keys means, etc.  This separation of "is it grammatically correct"
and "does it make sense" is a sensible one to make, we make the same
separation when talking about human language:

~~~
the cat sat on the mat
the mat sat on the cat
~~~

are both grammatically correct sentences in English. We need to know
something about what a "cat" and a "mat" is, and if either is
something that can "sit" on something else before we can conculde that
the first sentence makes sense while the second one does not.

Additionally, we could have a grammatically correct sentance that only
makes sense in a particular context depending on the state of the game
world:

~~~
> unlock door with key
~~~

makes sense only if the player has a 'key' in their posession.
Determining this requires intement knowledge of the game data,
something we do not want our parser to have, so the parsers job will
just be to determin whether or not a given command is grammatically
correct.

Let's use the same thinking and define a grammar for our game

~~~ ebnf
command = action noun_group | action noun_group preposition noun_group
preposition = 'with' | 'at'
noun_group = noun | noun ',' noun_group | noun 'and' noun_group
noun = [number] word
~~~

