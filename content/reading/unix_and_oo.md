---
title: Unix and Object-Oriented Languages
kind: reading
---

- Read [Unix and Object-Oriented Languages][unix_oo_taoup] from [TAOUP]
- Read [Coding for Modularity][coding_for_modularity] from [TAOUP]

[coding_for_modularity]: http://www.catb.org/esr/writings/taoup/html/ch04s06.html
[unix_oo_taoup]: http://www.catb.org/esr/writings/taoup/html/unix_and_oo.html
[TAOUP]: http://www.catb.org/esr/writings/taoup/html

## Self Study

1. Program solutions can generally be divided into data structures,
   like lists, stacks and queues, and algorithms, like sort, tree
   traversal, etc. Of the two broad categories: "data structures" and
   "algorithms", which is a more natural candidate for using an
   Object-Oriented style?

2. OOP and non-OO styles may be sucessfully combined in the same
   project.  Even though C is not an Object-Oriented language, we can
   implement the encapsulation of objects using C `struct`s and a
   consistent naming convention for functions that operate on
   particular `struct`s. Take a look at
   [the source for the analytics library](https://github.com/ECE2524/libanalytics/tree/master/lib),
   which parts are implemented in more of an OO style and which are
   not?

3. C++ *is* an Object-Oriented language, all of the
   [Standard Containers](http://www.cplusplus.com/reference/stl/) are
   implemented as objects (click on a few and confirm they have a
   constructor).  What about the
   [algorithms provided by the STL](http://www.cplusplus.com/reference/algorithm/),
   are they implemented as objects?
