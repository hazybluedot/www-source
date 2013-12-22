---
title: Midterm Topics
---

## Things to know

- git
    - fork and clone an existing repository
    - initialize a new repository in a given directory
    - add a remote to a repository
    - add and commit files to a repository
    - push local changes to a remote repository
- navigating the shell
    - be aware of what your current working directory is
    - change your current working directory to a different location
    - copy, move or rename files and directories
    - list files in current directory or another directory
    - understand long listing of `ls` (identify user, permissions, size, etc. of a given file)
    - understand differences beteween absolute and relative paths
- shell redirection and pipelines
    - understand each part of [word frequency pipeline](http://goo.gl/kbRSzR)

            tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -c | sort -rn | sed ${1}q
    - use `grep` to filter lines of input from standar in, or one or more files.
- C/C++
    - be able to write a `main` function and iterate over a list of command line arguments
    - know how to interpret subset of argument list as list of files to open and perform some action on the resulting character stream
    - and if no file arguments are given, perform the same action on the standard input stream
    - understand what "strong single center" means, especially in the context of the balanced brace checker project.
- make
    - understand vocabulary: *target*, *prerequisite*, *recipe*
    - write rules to build a target
    - separate rules to compile object files (.o) and link binary
    - use user variables and `make` automatic variables to stay DRY
- regular expressions (exercises/reading for Wednesday)
    - understand regular expression matching rules to the extent of
      what are used in the test cases.
