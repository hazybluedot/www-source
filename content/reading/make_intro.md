---
title: "Introduction to make"
kind: reading
provides: { background: [ build/tools/make ] }
---

- Read
  [Overview of make](http://www.gnu.org/software/make/manual/make.html#Overview)
- Read
  [An Introduction to Makefiles](http://www.gnu.org/software/make/manual/make.html#Introduction)
  through and including
  [How `make` Processes a Makefile](http://www.gnu.org/software/make/manual/make.html#How-Make-Works)

## Self Study

1. What criteria does `make` use to determine if a particular file
   needs to be re-built?

1. Why doesn't `make` just recompile all files in a project every
   time?

1. Can you think of any applications of `make` for projects that may
   not follow the conventional "compile source code into a working
   binary" workflow?

1. Write out a pseudo-code progam that would process a simple
   `Makefile` consisting of only rules (i.e. only the parts covered in
   the reading, no variable assignment or other features).
