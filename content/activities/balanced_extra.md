---
title: "Extra 'balanced' features"
kind: activity
requires:
  - understanding: exit_status
  - background: cla_parsing
provides:
  - practice: [ exit_status, cla_parsing ]
tests:
  - type: bonair
    feature: features/balanced
    tags: [ extra ]
language: C
repos:
  - fork: skel/balanced
    user: USER/balanced
---

# Handle Multiple Brace Types and Ignore C-style Comments

You do not need to ignore quoted strings, as they will not appear in
the test input.

