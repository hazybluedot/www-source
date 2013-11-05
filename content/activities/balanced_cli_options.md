---
title: "A real CLI: add CLA parsing to 'balanced'"
requires:
  - understanding: exit_status
  - background: cla_parsing
provides:
  - practice: [ exit_status, cla_parsing ]
tests:
  - type: bonair
    feature: features/balanced
    tags: [ part4 ]
language: C
repos:
  - fork: skel/balanced
    user: USER/balanced
---

## Defining the Interface When there is a convention to follow, it's
   best to follow the convention
   ([Rule of Least Surprise](http://catb.org/~esr/writings/taoup/html/ch01s06.html#id2878339)). Most
   commands use the `-h` option to return a help or usage message
   (`grep` is a notable exception).

## Discussion We have seen how
   Unix design choices have been made to conciously simplify the
   developers task. For example, the ease of redirecting standard
   streams to arbitrary files frees the developer from writing in
   custom code to write normal output to a user-supplied file.

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
   It also added a bit of complexity that the developer has to deal
   with: parsing command line options and setting flags to control
   output behavior.  Why would a developer choose to increase
   complexity of their program in this way? Are there some cases where
   this would make sense? Are there others where it would be best to
   leave it to the user to redirect output to `/dev/null`?
