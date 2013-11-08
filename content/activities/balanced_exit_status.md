---
title: Balanced Exit Status
kind: activity
tests:
  - type: bonair
    feature: features/balanced
    tags: [ part2 ]
requires:
  - background: ipc/exit_status
provides:
  - practice: ipd/exit_status
repos:
  - fork: skel/balanced
    user: USER/balanced
---

## Implement Error Reporting

If you haven't already, add code to your `balanced` program to print a
message to *standard error* when a file can not be opened, formatted
as:

~~~ text
filename: error message
~~~

Use the `perror` library function defined in the `stdin.h` header to
easily print out formatted warnings like this.  Note that `perror` will
provide the name of the program `balanced` and the error message
obtained from the global `errno` variable.  You just need to pass it a
string containing the name of the file.

~~~ c
#include <stdio.h>

...
// error opening *argv
perror(*argv)
...
~~~

alternatively you could use the `warn` call defined in `err.h` for a
similar effect:

~~~ c
#include <err.h>

...
// error opening *argv
warn("%s", *argv)
...
~~~

Both `warn(3)` and `perror(3)` have manual page entries.

Once you have added the error message output add and commit your
changes with an appropriate commit message.

## Implement Exit Status
   
   Modify your `balanced` program so that the exit status reflects
   whether or not balancing errors occured

   An exit status of 

   - 0, normal exit. no balancing errors occured
   - 1, balancing errors
   - 2, unable to process all input

   In the event of multiple command line arguments, the highest
potential exit status value should take precedence. Add and commit
your changes with an appropriate commit message.


## Test From the Command Line

Assuming `good.c` doesn't contain any balancing errors, we expect the
exit status to be `0`

~~~ bash
   $ ./balanced good.c
   $ echo $?
~~~

Given a file `test1.c` containing a blanancing error, we expect the
exit status to be `1`

~~~ bash
   $ ./balanced test1.c
   $ echo $?
~~~

And assuming a file named `badfile.c` does not exist, then we expect
the exist status of the following command to be `2`.

~~~ bash
   $ ./balanced badfile.c
   $ echo $?
~~~

## A Very Brief Introduction to Shell Scripts

   A shell script is nothing more than a text file containing one or
   more shell commands. Anything you have been running from the
   command line you could put into a file, make it executable and you
   have a shell script. To tell the system that a particular file
   should be executed as a shell script include an appropriate
   *shebang* line:

~~~ bash
#!/bin/sh
~~~

or, if you know your script will use `base`-specific syntax

~~~ bash
#!/bin/bash
~~~

The *shebang* line must be the first line of the file to take effect.
Finally, make your script executable.  Assuming you have written your
script in a file named `myscript.sh` run

~~~ bash
chmod 700 myscript.sh
~~~

to allow only you to run `myscript.sh` as an executable, or

~~~ bash
chmod 755 myscript.sh
~~~

if you want all users on the system to have permission to run your
script.  Remember, `Unix` doesn't care about file extensions. It is
common to use the `.sh` file extension when naming shell scripts just
as a reminder to the user, but it is not necessary.
   
## Write a Shell Script

Now try writing a simple shell script that makes use of our `balanced`
   program. Because the shell's `if` condition checks for exit status
   we can very cleanly create branch conditions based on the success
   or failure of a particular command. The special shell variable `$@`
   is the argument array, just like `argv` when writing in C or C++.
   
~~~ bash
   #!/bin/sh

   if ./balanced "$@"; then
       echo "No balancing errors in any input file"
   else
       echo "some error occurred"
   fi
~~~

Or for a clean way of handling each possible exist status case, try a
`case` statement:

~~~ bash
   #!/bin/sh

   ./balanced "$@"
   case "$?" in
   0)
      echo "No balancing errors"
   ;;
   1)
      echo "Balancing errors"
   ;;
   2)
      echo "Unable to process all files"
   ;;
   *)
      echo "Unknown exit status" >&2
   ;;
   esac
~~~

   Note the `bourne`/`bash` shell's convention of closing `if` and
   `case` blocks with the opening word spelled backwards: `fi` and
   `esac`, respectively. If this were not odd enough `for` and `while`
   loops don't follow the same rule.

   Of course, if we want to use our program in
   this fashion the output it produces is superfulous and clutters the
   output of our script.  We could simply redirect the standard out of
   the program to `/dev/null` to discard it, but since it seems like
   this could be a common use of our utility we may want to add a
   command line option that suppresses normal output, just like
   `grep`'s `-q` option.

