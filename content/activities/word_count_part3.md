---
title: "Word Frequency Count: Part 3"
prereq: activities/word_count_part2
kind: activity
requires: { practice: [ 'activity/wordfreq/part2' ] }
provides: { practice: [ 'git/collaboration', 'cla/getopt', 'ipatterns/catlike' ] }
tests:
  - type: bonair
    feature: features/wordfreq
    tags: [ compile, part3 ]
repos:
  - user: USER/wordfreq
---

## Implement 'catlike' interface pattern

- `user1`: implement and test 'catlike' iterface pattern as shown in
  class.

  Any additional command line arguments that do not start with `-`
  should be treated as file names to read from. Attempt to open each
  argument as a file and append the words contained into a single word
  list (replace the call to `split_words` with a call to
  `append_words`, implementation shown below.

  If no additional arguments are given then the program should work
  exactly the same as it did for
  [part 2](/activities/word_count_part2/), i.e. read from *standard
  input*.

  ~~~~ c
  void append_words(word_list_t wl, FILE* fp) {
      /* append words found in fp to list wl */
      token_inject(fp, " \n\t.,?!-", wl, word_list_injector, TOK_INJECT_COMPACT);
  }

  int main(int argc, char *argv[]) {
      /* variable declarations */
      word_list_t wl;
      FILE* fp;

      /* call getopt in while loop */

      wl = word_list_create(100); /* used to be done in split_words,
                                   * which we are no longer using */

      /* optind will contain the offset from the start of the original
       * argv to the first argument not consumed by getopt */
      argv += optind; 
      argc -= optind;

      /* now use argv as a list of remaining command line arguments. */
      if ( argc > 0 ) {
          /* any arguments left over after getopt should be treated as
           * file names */
          do {
              fp = fopen(*argv, "r");
              /* TODO: user2 implement error checking */
              append_words(wl, fp);
          } while (*++argv);
      } else {
          /* no additional arguments means read from standard input */
          append_words(wl, stdin);
      }
    
      /* remainder of program shouldn't need to change from part 2,
       * but since append_words replaces split_words, you won't need
       * that line */
  }
  ~~~~
  
  update the usage message to reflect the new functionality:

  ~~~~ console
  $ ./wordfreq -h
  Usage: ./wordfreq [-hr] [-k N] [FILE ...]
  ~~~~
  {:.no-explain}

- `user2`: after `user1` has completed their work, add error checking
to handle filenames that can not be read.

  If a given command line argument referrs to a file that does not
  exist, or can not be read then print a cooresponding message to
  *standard error* and continue to the next file in the list.

  Assuming files named `file1` and `file2` exist and are readable,
  but no file named `not_a_file` exists, then the standard output of

  ~~~~ console
  $ ./wordfreq file1 file2
  ~~~~
  {:.no-explain}
  
  and

  ~~~~ console
  $ ./wordfreq file1 not_a_file file2
  ~~~~
  {:.no-explain}

  should be identical, but the latter command should also produce a message on *standard error*:

  ~~~~ text
  not_a_file: No such file or directory
  ~~~~
  {:.no-explain}

  Remember, don't do more work than you have to. You don't need to
  know the reason `fopen` failed to open a file, just that it will set
  the global `errno` with some value. Use `strerror` to generate a
  human-readable message from the global `errno`.
  
  ~~~~ c
  #include <stdio.h>
  #include <string.h>

  ...
  
  fprintf(stderr, "%s: %s\n", *argv, strerror(errno));
  ~~~~

  Alternatively, you
  could use the `warn` function defined in `err.h`.

  ~~~~ c
  #include <err.h>

  ...
  
  warn("%s");
~~~~

## Compiling and Linking

If you receive linking errors about 'token_inject' being undefined, you may have to tell the linker to explicitly link to the `streamtoken` library:

~~~~ console
$ clang -o wordfreq -lanalytics -lstreamtoken main.o
~~~~
{:.no-explain}

The extra `-lstreamtoken` option is not needed if compiling with
clang 3.4 on the ece2524 VM but I found it necessary when using
clang 3.3 on my local machine.
