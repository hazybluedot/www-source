---
title: "The Final Piece: Command Parser"
kind: activity
---

## Command Parser

- read a line
- split the line
- use first word in line to route to a particular API function,
  passing remaining words as arguments

## Design Rule Discussion

- [Rule of Modularity: Write simple parts connected by clean interfaces.][rule_of_modularity]
- [Rule of Composition: Design programs to be connected with other programs.][rule_of_composition]
- [Rule of Representation: Fold knowledge into data, so program logic can be stupid and robust.][rule_of_representation]

- What would we need to do if we wanted to handle more path directions
  (e.g. 'northeast', or 'up' and 'down'?)
- There is redundant information in our data file: we must specify
  that Room A leads to Room B in the north *and* that Room B leads to
  Room A in the south. Is this a problem? If we wanted to be more DRY,
  what could we do?
- Could we follow a filter interface pattern like `bc` (implement an
  interactive mode and a batch mode)

[rule_of_modularity]: http://www.catb.org/esr/writings/taoup/html/ch01s06.html#id2877537
[rule_of_composition]: http://www.catb.org/esr/writings/taoup/html/ch01s06.html#id2877684
[rule_of_representation]: http://www.catb.org/esr/writings/taoup/html/ch01s06.html#id2878263

## More Complex Parsing

What if you wanted to handle commands such as

~~~~ text
> throw ball at window
> fight monster with magic sward
> drop 5 candles
~~~~

- regular expressions
- flex/bison (and Python's C bindings)

  
