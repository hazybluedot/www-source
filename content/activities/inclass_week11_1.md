---
title: "make and more"
kind: activity
---

## Questions from last week

- how are "easy IPC" and "single process monolith" related?
- Culture and technical reasons Engine Interface separation more common in Unix
- `bc` uses `isatty(3)` to switch between interactive and non-interactive
  modes (see source at `/usr/src/bc-1.06/`)

## `make` and Makefiles

- a DSL to describe dependancy trees

- a list of rules

~~~~ make
target : prerequisites
       recipe
~~~~
