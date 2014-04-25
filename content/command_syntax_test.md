---
title: A test page for command stuff
---

## IRC command sub

When I write a code block with

~~~~~ irc
/msg RoboRitchie my pid is <pid> and <stuff>
~~~~~

it displays as

~~~~~ irc
/msg RoboRitchie my pid is <pid> and <stuff>
~~~~~
{: .command-syntax }

## Shell command sub

When I write a code block with

~~~~ console
$ grep '<your-expression>' file1 ><your-file>
~~~~

it displays as

~~~~ console
$ grep '<your-expression>' file1 ><your-file>
~~~~
{: .command-syntax }

And just one more, from class

~~~~ console
$ grep 'http:' user-data/feeds | wc -l 
~~~~
{: .command-syntax }

What about a nice multi line input/output test?

~~~ console
$ tr 'A-Z' 'a-z'
:Hello World
hello world
:^d
$ ls
file1
file2
~~~
