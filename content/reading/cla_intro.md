---
title: Introduction to Command Line Argument Parsing Libraries
provides:
  - background: cla_parsing
---

## Motivation for Command Line Argument (CLA) parsing libraries

As you have seen with the commands we have been using, command line
arguments are a large part of the user interface for command line
tools (in many cases they *are* the user interface). Most utilities
accept command line options to control the behavior of the tool and
provide more flexibility and power to the user.  Since argument
parsing is something that nearly all command line tools do it
shouldn't come as a suprise that there are library functions to aid in
this important step.

So why go through the trouble of learning the ins and outs of a new
library function? We already know how to use `argc` and `argv` to grab
strings that the user has provided on the command line, so why can't
we just using `argc` and `argv` directly to extract any arguments.  We
certainly could, but let's take a look at some of the situations we
would like to handle.

Consider the `head` utility and recall that its basic behavior is to
write the first `N` lines of a file to /standard output/ where `N` is
an integer and defaults to 10. Of course `head` would be much less
useful if the user couldn't set `N` at runtime, but luckily the
utility accepts a `-n` option to allow for different values of `N`:

~~~ bash
head -n 5
~~~~

will write the first 5 lines of input to /standard output/.  Knowing
what we do about the `argv` array we can deduce that the contents for
the above command would look like

~~~ c
argv[0] = "head"
argv[1] = "-n"
argv[2] = "5"
~~~

We could scan trough the array looking for `-n`, and if we find it,
look at the next item in the array, convert it to an integer if
possible and store the result in some local variable.  If the value
could not be converted to an integer, for instance, if the user ran
the command

~~~ bash
head -n five
~~~

we would want to print a message to /standard error/ indicating why
the command can't execute what the user requested (try running the
previous command to see how `head` responds).

So far this sounds fairly managable, if a little tedious. But `head`
also accepts a `-q` option, that stands for "quiet".  Without `-q`
when `head` is given multiple input files it will display a line with
the file name before the output from each file, `-q` will supress this
behavior.  Since the behavior is determined by the name of the
argument and not the order in which they are given, `head -n 5 -q` and
`head -q -n 5` should both do the same thing.  In addition, by
convention single letter command line arguments can be grouped with a
single `-` to save typing, so `head -qn 5` will also do the same
thing. Since `-n` requires an additional argument, `head -n` or `head
-qn` will generate an error message, as will `head -q 5 -n` since the
value for `-n` must be given immediately after the argument itself.

Already your head is probably spinning a bit trying to think about the
logic we would need to handle all of these cases. It's not
particularly difficult if you just take it step by step, but it's
tedious, and since it *is* something that can be solved in a very
algorithmic way, it probably should be, to avoid the inevitable human
error that will be introduced by trying to repeat this process over
and over again for every new command line utility you write.

## Activities
- [Balanced Brace Checker](/activities/balanced_cli_options/index.html)
