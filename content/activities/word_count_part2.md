---
title: "Word Frequency Count: Part 2"
prereq: activities/word_count_part1
kind: activity
provides: { practice: [ 'git/collaboration', 'cla/getopt', 'activity/wordfreq/part2' ] }
requires: { background: [ 'cla/intro2', 'cla/wordfreq'], practice: [ 'activity/wordfreq/part1' ] }
tests:
  - type: bonair
    feature: features/wordfreq
    tags: [ compile, part2 ]
repos:
  - user: USER/wordfreq
---

Both user's code should contain a barebones implementation of the
`getopt` loop (see
[example source](/activities/inclass_getopt/#source-code) ) that
parses `-k` and `-h` options.

1. Each group member implement a specific feature in your local code.

   `user1`: add error checking to the `strtol` call (see EXAMPLE
   section of man page for `strtol`).  Only set the variable
   containing the value for *k* if a valid integer was present in the
   option argument for `-k`.  If no argument was given, or the
   argument did not contain an integer then print an error to
   _standard error_ and exit.

   ~~~~ console
   $ ./wordfreq -k
   ./wordfreq: option requires an argument -- 'k' 
   Usage: wordfreq [-h] [-k N]
   $ ./wordfreq -k five
   No digits were found
   Usage: wordfreq [-h] [-k N]
   ~~~~
   {: .no-explain}
   
   Note that the first line of output shown is generated automatically
   by `getopt` if you configured it properly i.e. configuration string
   should be "k:".
   
   `user2`: add a `-r` option that when present will cause the program
   to print the word list in reverse frequency order (least frequently
   used words first).

   ~~~~ console
   $ ./wordfreq -r
   ~~~~
   {: .no-explain}

   The API for the analytics library has been
   updated to reflect support for sort options. The `opt` paramter to
   [`sort_counted_words`][sort_counted_words] can be set to either `AMAP_SORT_ASCENDING`
   or `AMAP_SORT_DESCENDING` for sorting in ascending or descending
   order, respectively.

   [sort_counted_words]: /assets/api/analytics/analytics_8h.html#a5610c5e9c2fe3b9520f8f67446d60223

   Note: `user2` be sure to update the Usage message to include the `-r` option:

   ~~~~ console
   $ ./wordfreq -h
   Usage: wordfreq [-hr] [-k N]
   ~~~~
   {: .no-explain}
   
2. Each group member add/commit and push changes to your own `origin`

3. `user1` pull changes from `user2`'s remote:

        user1@local $ git pull user2 master

   ideally git should merge the changes automatically.  If you receive
   a message about a conflict in `main.c` you will need to open that
   file in an editor and perform a manual merge.


4. Once `user1` has successfully merged, push the merged code back to
   your own `origin`.

       user1@local $ git push origin master
       
5. `user2` can now pull from `upstream` to update their local copy with the merged code

   ~~~~
   user2@local $ git pull upstream master
   ~~~~
   {: .language-console}

## Merge conflicts

Because both people will be modifying the top part of main where
veraibles are declared `user1` will likely be notified of a conflic in
`main.c` when they pull from `user2`'s remote. When this occurs, open
`main.c` in your text editor to see what the problem was, you will see
something like the following:

~~~~ c
int main(int argc, char *argv[]) {
    long int nlimit=10, val;
    word_list_t wl;
    word_map_t wm;
<<<<<<< HEAD
    int opt;
    char *endptr;
=======
    int opt, sort_opt = AMAP_SORT_DESCENDING;
>>>>>>> 8ec39be37ec486ea8670ceb57fb70e4fa6b0b3aa

    /* remainder of implementation */

}
~~~~

You only need to concern yourselfe with code between the lines
starting with `<<<<<<<` and `>>>>>>>`, lines outside this region were
merged automatically by git.  In the preceding example git is telling me that the lines

~~~~ c
    int opt;
    char *endptr;
~~~~

in `user1`'s `HEAD` (the current state of your code when you performed
the merge), and the line

~~~~ c
    int opt, sort_opt = AMAP_SORT_DESCENDING;
~~~~

which were in the remote user's code (the 40 character hexadecimal
string is the commit id of the particular commit of the merged
changes), are in conflict.  In the example above, `user1` has added
the `char *endptr;` declaration which is used for the `strtol` error
checking while `user2` has added the `sort_opt` declaration used for
the sort option. Both are needed, so in this case I could edit the
file to look like

~~~~ c
int main(int argc, char *argv[]) {
    long int nlimit=10, val;
    word_list_t wl;
    word_map_t wm;
    int opt;
    char *endptr;
    int sort_opt = AMAP_SORT_DESCENDING;

    /* remainder of implementation */

}
~~~~

The result should be the complete, merged source file. Notably, you
must manually remove the three lines added by git (starting with
`>>>>>>>`, `<<<<<<<` and `=======`) so that `git` knows the conflict
has been resolved.

Once you have resoled a merge conflict by making the necessary changes
to the associated files be sure to compile the program to make sure it
works as expected, then add and commit the merged file:

    $ git add main.c
    $ git commit

Because the change is part of a merge `git` will populate the commit
message with text about the merge. In most cases you will probably
just leave the generated message as is.
