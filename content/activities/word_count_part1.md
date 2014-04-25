---
title: Word Frequency Count
kind: activity
provides: { practice: [ modularity, API/use, 'activity/wordfreq/part1' ] }
tests:
  - type: bonair
    feature: features/wordfreq
    tags: [ compile, part1 ]
repos:
  - user: USER/wordfreq
---

## The Task

Using the library provided, write a program that solves the classic
word count problem:

> Given a text file and an integer _k_, print the _k_ most common
> words in the file (and the number of their occurrences) in
> decreasing frequency. -- Jon Bentley, programming pearls

For the first part of this project, make the following simplifying assumptions:

1. _k_ can be set to 10, but we will generalize the program later for
   arbitrary _k_, so store this as a variable initialized to '10'.
2. Input will be read from _standard input_, you will not have to open
   any files. A `FILE*` stream named `stdin` corresponding to _standard input_ is
   defined in `<stdio.h>`.
3. all input text will be lowercase

## The API

I have created a library named `analytics` that provides a number of
functions relating to processing words from text.  The full doxygen
generated API is available.  For this project the following functions
will be useful:

- Each of the three functions defined in [analytics.h](/assets/api/analytics/analytics_8h.html)
- The [word_map_nforeach](/assets/api/analytics/word__map_8h.html#ab55c482c97dd70605c09420b61889c12) function defined in [word_map.h](/assets/api/analytics/word__map_8h.html)

Note that you don't need to know the implementation details of
'word_list_t' or 'word_map_t' to use them (but if you want to,
[use the source](https://github.com/ECE2524/libanalytics)!). Just that
one is a list of words and the other is a list of word,number
pairs. The functions defined in
[analytics.h](/assets/api/analytics/analytics_8h.html) either accept
these types as parameters, or return them.

### Callback functions

The function
[word_map_nforeach](/assets/api/analytics/word__map_8h.html#ab55c482c97dd70605c09420b61889c12)
takes a parameter that is a function pointer.  This works the same way
as a data pointer, but instead of containing a memory address that
points to a data value a funciton pointer's value points to a function
which can then be called from within the calling function.  This is
used to allow you to work with the items contained in the `word_map_t`
type without knowing the implementation details of that data structure
(other than the type).

A word map item contains a word (`const char *`) and a count (`int`),
if you look at the parameter `fnct` accepted by `word_map_nforeach` it
has a type of

~~~~ c
void(*fnct)(const char*, int)
~~~~

which is a pointer to a function that returns `void` and takes 2
parameters, the first of type `const char*` and an the second of typpe
`int`.  As an example:

~~~~ c
void some_callback(const char* word, int count) {
    // do something with 'word' and 'count'
}

int main() {
   int nlimit = 10;
   word_map_t wm;
   
   /* other variable declarations */

   /* calls to library functions (at least one must initialize wm) */

   /* if you pass an uninitialized 'wm' to this function your program
      will crash due to a Segmentation fault */
   word_map_nforeach(wm, some_callback, nlimit);

   return 0;
}
~~~~

since we want to print the sorted word count, the code in your call
back should print out the value of `count` and the string `word`.
This can be done in a single line with `printf`.

## Initialize a git repository

I will assume all the source files for this project (there will
probably be just one!) will live in `~/ece2524/wordfreq` (for "word
frequency").  Adjust the commands accordingly if you use a different
path.

    $ git init ~/ece2524/wordfreq
    $ cd ~/ece2524/wordfreq

## Write a `main`

The main function for this part will be very short, all of the
complexity is hidden away in the library I provided you.

~~~~ c
#include <stdio.h>

#include <analytics.h>

int main() {
    //variable declarations

    //calls to library functions

    return 0;
}
~~~~

## Compile an object file

First, compile the object file(s) for your own code. Assuming you have
a source file named `main.c`, run

    $ clang -c -o main.o main.c

The `-c` flag tells the clang to just compile the source file `main.c`
into an object file `main.o` without completing the final linking
step.

## Linking to a shared library

To create a working program you need to link the object file so that
the program knows where to find the code for the library calls.

    $ clang -o wordfreq main.o -lanalytics

Note: The `analytics` library is installed on the ece2524 VM, so the
above command will work if you are compiling from your shell account.
If you would like to compile and link locally you will have to install
the library on your own machine. The
[source is available on github](https://github.com/ECE2524/libanalytics).

## Test Before Push

Always test your program before submitting, it is much easier to debug
output inconsistancies when you can run the code and make adjustments
quickly. Errors you get locally will generally be easier to understand
than those that come back from the automatic testing. Create a couple
input files, starting with the two that are used in the tests (see
below) and run your program with each of them.  Does the output match
what you expect?

~~~~ console
$ cat >numbers << EOF
:four two four one
:two four three three
:three four two
:EOF
$ ./wordfreq <numbers
4 four
3 three
3 two
1 one
$
~~~~
{: .no-explain}

The tests in the [Testing](#testing) section use regular expressions
to match lines with arbitrary whitespace, the fancy syntax just tells
the test to match regardless of extra whitespace around the numbers.

## Add and commit your changes

The *only* file you should add to your repository is `main.c`.  Do not add any of the generated files.

    $ git add main.c
    $ git commit

You can use a commit message of "`initial commit`" for the first
commit, but after that use a message that is descriptive of what you
changed since the last commit.

## Add a remote

Add a remote named `origin`

~~~~ console
$ git remote add origin git@ece2524.ece.vt.edu:<cvl_username>/wordfreq.git
~~~~
{: .command-syntax .no-explain}

## Push your changes

~~~~ console
$ git push -u origin master
~~~~

On subsequent pushes you can just run

~~~~ console
$ git push
~~~~

Remember, `git` only pushes what is in your repository, which is only
what you explicitly `add` and `commit`.  If you make any changes to
your source file you will have to `add` and `commit` those changes to
the repository if you want them to get pushed to the server.
