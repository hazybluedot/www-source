---
title: Files, Processes and Pipes
provides: { background: system/file_descriptor, system/process, system/pipe }
---

## File Descriptors, Processes and Pipes, oh my!

For a more in-depth understanding of how processes and files work at the system level:

Read [Chapter 0](http://pdos.csail.mit.edu/6.828/2012/xv6/book-rev7.pdf#page=7) of "xv6: a simple, Unix-like teaching operating system"

The [xv6 operating system](http://pdos.csail.mit.edu/6.828/2012/xv6.html) was developed at MIT for their operating systems engineering class.  Chapter 0 of the documentation provides a really nice overview of what is going on at the system level when you run a command, redirect input/output, etc.

## Self Study

1. This reading provides some insight about what is going on at the
   system layer when we start a program from the command line,
   redirect standard I/O, etc.  Run a couple commands you are familiar
   with and think about what is going on at the system level when you
   run each one.

2. What is the relationship between the C standard I/O library calls
   such as `fputc`, `fgetc`, `fputs`, etc. and the system calls `read`
   and `write`?

3. What is the relationship between the `FILE` type defined by the C
   standard libraries, and file descriptors. What does the `fileno`
   library call do?

