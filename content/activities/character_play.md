---
title: Character Play
kind: activity
requires: { background: [  tools/editor_intro, examples/tolower.c ] }
provides: { practice: [ patterns/stdio ] }
---

## Play

Take a look at the other functions available to you in the
[standard C library](http://www.cplusplus.com/reference/clibrary/). Specifically
look at [stdio.h](http://www.cplusplus.com/reference/cstdio/),
focusing on "Character input/output" for now, and all functions
defined in [ctype.h](http://www.cplusplus.com/reference/cctype/).

1. Try looking at the `man` page for a few of the functions from the
   terminal, for example:

       $ man isspace

   The manual page is a valuable reference right at your finger tips.
   You can quickly look up what header files you will need to
   `#include` to use a particular function, what arguments a function
   takes and what it returns, as well as possible error
   considerations. From within the manual page viewer, press `q` to
   quit.  I find it useful to keep a second window open that I can use
   to check the manual as I am writing code.

2. Try using some of the other functions available to you to make your
   program do some different character operations:

   1. convert all characters to upper case
   2. print only alphabetic characters
   3. replace all non-alphabet characters with a new line character '\n'
   4. capitalize the first letter of each word

   Compile each program to a different name, for instance, you might
   call the program that replaces all non-alphabet characters with a
   new line `split_words`

   ~~~ console
   $ clang -o split_words split_words.c
   ~~~
   {: .no-explain }

   And try using your program in a pipeline with other programs you have written, for example

   ~~~ console
   $ ./tolower | ./split_words
   ~~~
   {: .no-explain }

   Try it with both input from the keyboard, and redirecting standard input to read from the a file

   ~~~ console
   $ < /usr/share/data/jump.txt ./tolower | ./split_words
   ~~~
   {: .no-explain }


   Note that the input redirect can come before or after the initial command:

   ~~~ console
   $ ./tolower < /usr/share/data/jump.txt | ./split_words
   ~~~
   {: .no-explain }

   will also work, but 

   ~~~ console
   $ ./tolower | ./split_words < /usr/share/data/jump.txt 
   ~~~
   {: .no-explain }
   
   will not produce the same behavior as the previous two examples. Why not?

## Compile Errors

The `clang` compiler is a good example of a program that follows the
"Silence is Golden" rule.  If your compile your program and there are
no errors, `clang` returns without printing anything to the terminal.
The only change is you will have a new or updated executable file in
your current directory.  If your source contains errors then `clang`
will print them to the terminal.  If this happens, read the error
message carefully.  Refer to the referenced line and column number in
your source code to find the spot the compiler had trouble with.  If
you don't see any obvious syntax errors or typos, review the `man`
page for the function that seems to be the source of the
error. Between the error message `clang` provides and the contents of
the manual pages, you should have all the information you need to fix
the problem.  If you aren't sure how to interpret an error that
`clang` gives you, ask a friend, ask the `#ece2524` IRC channel, or
ask me.


## Deliverables

You do not need to submit any of your programs. Use them to experiment
and learn how to use some of the functions in the standard library.
The next quiz will contain questions that you should be able to answer
after having worked through these exercises.
