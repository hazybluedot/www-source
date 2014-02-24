---
title: "My Own `tr`"
kind: activity
requires: { practice: [ vcs/git/intro ], experience: [ patterns/stdio, lib/ctype ] }
tests:
  - type: bonair
    feature: features/motr
---

## Complete the motr program

Here is what we completed in class:

~~~ c
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int c;
    char *pch;

    if ( argc < 3 ) {
        fprintf(stderr, "Usage: %s SET1 SET2\n", argv[0]);
        exit(-1);
    }

    while ((c = getchar()) != EOF) {
        pch = strchr(argv[1], c);
        if ( pch != NULL ) {
            //TODO: replace the character found with
            //the corresponding char in SET2
        }
        putchar(c);
    }
}
~~~

The goal is to create a program that accepts two command line arguments from the user: `SET1` and `SET2`.  The program will read characters from /standard input/.  Any characters found that are contained in `SET1` will be replaced with the equivalent (same index) in `SET2`.  For now assume that `SET1` and `SET2` are the same length.

Hint: The index of the character relative to `SET1` can be found by calculating the difference between the pointer address returned by `strchr` and the pointer address of the first character in `SET1`.

## Test your program

Try changing all vowels to the letter 'x':

~~~ console
$ ./motr aeiou xxxxx
:Hello World
Hxllx Wxrld
:^d
~~~
{: .no-explain }

Or all upper case `A`, `B` and `C` to lower case:

~~~ console
$ ./motr ABC abc
:THE CAT SAT ON THE MAT
THE caT SaT ON THE MaT
^d
~~~
{: .no-explain }

Or swap all `c`s and `m`s

~~~ console
$ ./motr mc cm
:the cat sat on the mat
the mat sat on the cat
:the mat sat on the cat
the cat sat on the mat
:^d
~~~
{: .no-explain }

## Commit your changes

You will first have to add the modified `motr.c` to the staging area:

    $ git add motr.c

then commit the changes

    $ git commit

Since we aren't using the `-m` option here `git` will open your default editor so that you can enter a commit message.  The message could be something like

    accept SET1, SET2 command line arguments

    Usage: ./motr SET1 SET2
    all characters in the input stream found
    in SET1 will be replaced with the character
    at the same index in SET2.
    No error checking is performed for
    index out of bound errors.

Once you have entered your message, save and quit from the editor to allow git to record the commit (if your default editor is `vim` then the key sequence would be `<Esc>` to get into COMMAND mode and then `:wq<Enter>`).
