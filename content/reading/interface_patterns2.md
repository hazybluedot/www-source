---
title: Interface Patterns Summary
---

- Read [Applying Unix Interface-Design Patterns](http://www.catb.org/esr/writings/taoup/html/ch11s07.html) from [TAOUP]
- Read [Silence Is Golden](http://www.catb.org/esr/writings/taoup/html/ch11s09.html) from [TAOUP]
- Connect to your shell account via PuTTY or ssh and read source of `bc` at `/usr/src/bc-1.06/bc/main.c`

  for syntax highlighting and easy line number open in `vim`, or run

  ~~~~ console
  $ source-highlight -f esc256 -s c </usr/src/bc-1.06/bc/main.c | less -NR
  ~~~~
  {: .no-explain}

[TAOUP]: http://www.catb.org/esr/writings/taoup/html/

## Self Study

1. Does our `wordfreq` program follow the Polyvalent-Program Pattern?

1. Has our `wordfreq` program followed the "Silence is Golden" rule? Why or why not?

1. Identify the functions defined in `main.c` of the `bc` source. At a
   high level, what does each one do?

1. At what line of `bc`'s `main.c` do each of the following modules start:

   - command line option parsing
   - the read/parse/execute interpreter loop (the loop itself is
     actually hidden away in a function, what is the name of this top-level
     function called in `main()`?)

1. Where in the source of `bc` is the check to determine interactive
   mode vs. non-interactive mode? What function is used? Read the man
   page for this function.
