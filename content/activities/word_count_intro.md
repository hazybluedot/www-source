---
title: "Word Count Program"
kind: activity
requires: { background: [ impl/wordfreq, shell/keyboard ] }
---

## Self Study

1. Run each command in McIlroy's pipeline independently with your own input. Gain an understanding of what each command does.

   ~~~ console
   $ tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -c | sort -rn | sed 10q
   ~~~

   for example

   ~~~ console
   $ tr 'A-Z' 'a-z'
   :Hello World
   hello world
   :^d
   ~~~

