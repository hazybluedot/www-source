---
title: Finding Your Way on the Filesystem
require: { background: shell/comfort }
provides: { practice: shell/comfort }
kind: activity
---

## Background

Read [Chapters 4-7](/assets/TLCL-13.07.pdf#page=49) of
[TLCL](/assets/TLCL-13.07.pdf).  Practice the commands at least once,
but don't worry about memorizing them, you will naturally memorize the
as you use them more often.

   - In chapter 5 the `which`, `man` and `alias` commands are the ones
     I find most useful.  I rarely if ever use the others. You're
     experience may be different, of course, but feel free to skip
     over the others for now.
   - Chapter 6 is very important.  The concept of redirection and
     pipes is central to the Unix command line and is what provides
     much of the power and flexibility of working from the command
     line.  Spend some time getting familiar with the syntax as it
     repurposes some symboles that have a different meaning in most
     other programming contexts.
   - If you spend more than an hour on this before getting through
     Chapter 7 stop and let me know on Monday.
   

## Self Study
1. What is the relationship between the `ln` command and "shortcuts" on Windows?
1. Why is the default behavior of the `cp`, `mv` and `rm` command to
   potentially overwrite or remove existing files without prompting?
1. Why are *standard output* and *standard error* two separate output
   streams? i.e. Why not just write regular output and diagnostic
   messages to the same output stream?
1. How does the concept of 'every program is a filter' fit in with the
   concept of Unix pipelines?
1. How does the shell's ability to perform input/output redirection
   simplify your job as a developer when writing programs?
