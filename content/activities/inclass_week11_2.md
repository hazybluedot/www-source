---
title: "make for real"
kind: activity
---

## Recap

- correction: `yacc` is the original Unix tool, `bison` is the GNU
  implementation. They are both parser generators (they take a grammar
  written in a special DSL and produce C or C++ code implementing a
  parser for that grammar).  The tools `lex` and `flex` are the classic Unix
  and GNU tools, respectively that generate a lexical analyzer: code that reads a character
  stream and turns it into a sequence of abstract symbols.

- Why did we spend the entire last class talking about program
  structure, mini-languages, and the two reasons (one cultural, one
  technical) the "Separate Engine and Interface" pattern is more
  common in the Unix world than outside it? How is this useful to you?

> The most dangerous phrase in the language is, “We’ve always done it
> this way.” - [Rear Admiral Grace Murray Hopper](http://franscomputerservices.wordpress.com/2013/12/09/amazing-grace-hopper-happy-birthday-and-rip/), USNR, (1906-1992)

## Finally: `make`

No, really, we'll actually get to this today.

## Another `make` example and "easy IPC"

See `/usr/share/twopipe/`

## Topics of Interest

We have a lot of potential topics to cover and not enough time, please
fill out [this survey](https://survey.vt.edu/survey/entry.jsp?id=1396993347074) by the end of the week (Friday, 11:59pm) to
indicate what you are most interested in covering in the remaining
weeks.
