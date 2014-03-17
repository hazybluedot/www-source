---
title: Compactness, Orthogonality, CLAs, oh my!
kind: activity
---


## Quiz Feedback

- the C type of data is superficial (usually) when asking about
  orthogonality, the key in the switch between a file name of type
  `char*` and a file stream of type `FILE*` is what the data is
  representing.
- Orthogonality and complexity are orthogonal components
- Orthogonality and compactness are orthogonal 

## Inspect the libanalytics

> use the source, Luke!

It's [on github](https://github.com/ECE2524/libanalytics).

### Setting `k`

Goal: allow the user to specify a value of `k` as a command line argument

    $ ./wordfreq -k 10 < jump.txt


We will start simple and just expect that the first command line argument will be the value of `k`, i.e.

    $ ./wordfreq 10 < jump.txt

recall that because the shell performs the redirection associated with `< jump.txt` it does not pass those characters along to the program.  In the preceding example the `wordfreq` will "see" 2 command line arguments:

~~~~ text
argv[0]: "./wordfreq"
argv[1]: "10"
argv[2]: NULL
~~~~

### converting `char*` to `long int`

    $ man strtol

We prefer `strtol` over the older `atoi` because we can perform more
robust error checking with `strtol` (in fact `atoi` can not detect the
difference between a string of "0" and a string of "not even a
number", both will return the integer value `0`). Let's modify our
program, making judicial use of trace code (printing to standard
error) to see what's going on.

~~~~ c
#include <stdio.h>
#include <stdlib.h> /* for strtol */

#include <analytics.h>

int main(int argc, char *argv[]) {
    int nlimit=10;
    /* additional variable declarations */

    if (argc > 1) {
        /* will be true if the user has supplied at least 1 command line
        argument */
        fprintf(stderr, "argv[1]: %s\n", argv[1]);
        /* argv[1] is a string (char*), but nlimit is an int */
        nlimit = strtol(argv[1], NULL, 10);
        fprintf(stderr, "nlimit: %d\n", nlimit);
        return 0; /* for testing, ignore the rest of the code for now */
    }

    /* rest of the implementation */
}
~~~~

Compile and run this with a few different command line arguments

~~~~ console
$ ./wordfreq 10
$ ./wordfreq "not even a number"
$ ./wordfreq
~~~~
{: .no-explain }

This as far as we got in class
{: .notice }

## Flexibility via CLAs

Parsing command line options

    $ man getopt

