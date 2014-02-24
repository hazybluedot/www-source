---
title: Permissions and Processes
kind: activity
---

## Office Hours

Based on feedback I will move my Monday office hours to some time on
Thursday.  I will make another announcement when I finalize a time.

## Quiz Feedback
1. Why is 400 the minimum permissions needed by `jump.txt`?
1. difference between `ps x` and `ps aux`
1. why won't `kill 1337` work?

We'll do some experiments to check all of these.

## File Permissions

1. inspect the permissions of a compiled binary (e.g. `motr`)
1. inspect hte permissions of a regular text file (e.g. `motr.c`)
1. manipulate permissions of files used for input/output redirection

### TODO

We didn't make it through these list items in the 'File Permissions' section that I had on my notes. We will probably get through some of them next class.

1. try to run `motr.c` as a command
1. write a simple build script
1. try to run it
1. set permissions
1. run it

## Processes and Signals

Source can be found in `/usr/share/src/week5/`

1. What does the process 'see'? (we didn't do this)
  - inspect argv with redirection
1. `infinite_hello` example
  - Try `^C`
  - Try `kill`

## Setup SSH Keys (we didn't make it this far)

    $ ssh-keygen

Inspect the permissions for the `~/.ssh/` directory and its files.
