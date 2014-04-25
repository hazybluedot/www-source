---
title: Option Parsing with getopt
kind: activity
requires: { background: [ 'cla/intro', 'cla/intro2' ] }
provides: { background: [ 'cla/wordfreq' ] }
---

# Contents
{:.no_toc}

* table of contents
{:toc}

## Announcements

- [Midterm Information and Practice](/activities/midterm_practice/)
- Submit examples of computing tasks you currently do manually (in
  particular, any kind of data manipulation or data format
  translation) for other classes or projects and I will go over
  Unix-command line solutions to automate them.

## Where we left off

- [Git Workflow for `wordfreq`](/reading/wordfreq_gitsetup/)

## Parsing Command Line Options

### Terminology

In general, command line arguments are the white-space separated words
that make up a command and are copied to the `argv` array.

    $ ./wordfreq -r -k 10

the `argv` array for this command will contain the following items:
    
    argv[0]: "./wordfreq"
    argv[1]: "-r"
    argv[2]: "-k"
    argv[3]: "10"
    argv[4]: NULL
    
We will call command line arguments that start with `-`, like `-r` and `-k` *options*.
Options that map to true/false type behavior (`-r` in this example) are often called *flags*.

The `10` is in general just an *argument*, but we may also refer to it
as an *option argument* or "the argument for option `-k`" to
distinguish it from arguments that are not associated with a
particular option (not present in this example, more on these later).

Parsing the `argv` array by hand becomes tedious once we need to handle more than a few options:

- check for required option arguments

      $ ./wordfreq -k 10

  should work, but

      $ ./wordfreq -k

  should print an error and terminate if `-k` is a valid option with a required argument.
      
- order shouldn't matter

      $ ./wordfreq -k 10 -r

  and

      $ ./wordfreq -r -k 10

  should do the same thing if `-r` and `-k` are valid options.

- we should handle option grouping


      $ ./wordfreq -c -r

  and

      $ ./wordfreq -cr

  should do the same thing if `-c` and `-r` are valid options.

This is as far as we got in class on Monday, we will start here on Wednesday, 3/19
{: .notice}

### Enter `getopt`

    $ man getopt
    $ man 3 getopt

## In-class Exercise

1. Either `user1` or `user2` modify your local `wordfreq` code to
accept a single option `-k` that takes a required argument which is
the number of uniq words to print.

   Whoever is not modifying the code should pay close attention to the
discussion of using `getopt` and make note of any key points and
useful tips.

2. Whoever modified the code should add/commit their changes and then
   push them to the server.  The other collaborator should then `pull`
   the changes from their partner's remote.  Depending on how you
   named your remotes the command will be either

       $ git pull upstream master

   if `user1` made the changes and `user2` is pulling, or

       $ git pull user2 master

   where `user2` is replaced with the username of `user2` if `user2`
   made the changes and `user1` is pulling.

### Source Code

The final code should look something like this:

~~~~ c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <analytics.h>

/* helper functions, such as print_counted_words */

void usage(int status, FILE *fp, const char* progname) {
    fprintf(fp, "Usage: %s [-h] [-k N]\n", progname);
    exit(status);
}

int main(int argc, char *argv[]) {
    long int nlimit=10;
    int opt;
    /* additional variable declarations */
    
    while ((opt = getopt(argc, argv, "hk:")) != -1) {
        switch(opt) {
        case 'h':
            usage(EXIT_SUCCESS, stdout, argv[0]);
            /* usage never returns, don't need break */
        case 'k':
            nlimit = strtol(optarg, NULL, 10);
            /* TODO: handle conversion errors, see strtol man page */
            break;
        default:
            usage(EXIT_FAILURE, stderr, argv[0]);
        }
    }

    /* remainder of program */
    
    return EXIT_SUCCESS;
}
~~~~

## Homework

[Word Frequency Count: Part 2](/activities/word_count_part2)
