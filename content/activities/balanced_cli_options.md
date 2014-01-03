---
title: "Add CLA parsing to 'balanced'"
kind: activity
requires: {
    understanding: exit_status,
    background: [ cla_parsing ]
    }
provides:
  - practice: [ exit_status, cla_parsing ]
tests:
  - type: bonair
    feature: features/balanced
    tags: [ compile, part3 ]
language: C
repos:
  - fork: skel/balanced
    user: USER/balanced
---

## Implement Command Line Argument Parsing

Let's implement a couple of command line options to our `balanced`
program to make it a little more flexible. When we use `balanced` in a
shell `if` statement to branch conditionally on balancing errors we
don't want the normal output of the program to clutter /standard
output/.  When there is a convention to follow, it's best to follow
the convention
([Rule of Least Surprise](http://catb.org/~esr/writings/taoup/html/ch01s06.html#id2878339)). Most
commands use the `-h` option to return a help or usage message (`grep`
is a notable exception). Utilities for which it makes since to supress
normal output will often use `-q` for "quiet". In this case `grep`
*is* an example of conventional use.

Implement the following command line arguments in your
`balanced` program.

- `-q` option for "quiet" that will supress all normal output.  Errors
reporting should not be affected by the "quiet"
- `-h` for "help" which generally displays a short usage summary of
the command and different options available. The usage summary should read:

        Usage: balanced [OPTION] [FILE]...

        Options:
          -q    suppress normal output
          -h    display this help message

Since we will want to display the usage summary both in the event that
an invalid option is given (the `default` case in the switch
statement), or when the `-h` option is used it would be best to put
the code to print the summary in its own function.  Additionally, if
the user requests help with `-h` then displaying the usage summary is
the correct output of the program and should be written to /standard
out/ and the program should exit with status 0.  If, however the user
uses an invalid option the summary should print to /standard error/
and the program should exit with status 3.
   
## Discussion

   We have seen how Unix design choices have been made to consciously
   simplify the developers task. For example, the ease of redirecting
   standard streams to arbitrary files frees the developer from
   writing in custom code to write normal output to a user-supplied
   file.

   The behavior of the `-q` option that we added to our program could
   easily be achieved if the user simply redirected standard output to
   `/dev/null`:
   
~~~ bash
   $ ./balanced -q test1.c
   $ echo $?
   $ ./balanced test1.c >/dev/null
   $ echo $?
~~~

   It's a little bit of extra typing for the user, but not too much.
   Handling the `-q` option added a bit of complexity that the
   developer has to deal with: parsing command line options and
   setting flags to control output behavior.  Why would a developer
   choose to increase complexity of their program in this way? Are
   there some cases where this would make sense? Are there others
   where it would be best to leave it to the user to redirect output
   to `/dev/null`?
