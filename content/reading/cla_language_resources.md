---
title: CLA parsing libraries
---

## Resources for other languages
- C: The `getopt(3)` library call is in the C standard library and can
  easily handle classic Unix style (single letter) command line
  options with optional or required arguments.  See the manual page
  for example code.
- C++: Of course you could use the `getopt(3)` library call in C++
  programs, and in many cases this may be the best option as it is
  part of the standard library so you know it will be available.  To
  handle more sophistocated option parsing, and especially if you are
  already using the Boost C++ library for your project, consider using
  [Boost.Program_options](http://www.boost.org/doc/libs/1_54_0/doc/html/program_options.html). This
  library is a nice example of a tool that makes it easier for the
  developer to follow the SPOT rule. You specify the help text for
  each option at the same time you specify the allowable options and
  the library generates a "usage" summary for you!
- Shell (sh/bash): The `getopt(1)` utility mirrors very closely the behavior of the `getopt(3)` library call.
- Python: [argparse](http://docs.python.org/dev/library/argparse.html)
  shares more similarities in usage with Boost.Program_options than
  `getopt(3)`.  We'll look at it in more depth when we start talking
  about Python.

