---
title: Standard IO Filter
provides: { background: patterns/filters/stdio }
requires: { background: structure/toplevel }
kind: reading
---

~~~ c
<<main loop>>=
    do {
        <<read chunk>>
        <<process chunk>>
        <<output chunk>>
    } while(<<chunks left to read>>);
@
~~~

The chunk size may be as small as 1 byte or as large as system
resources will allow.

- constant memory consumption with respect to input lenght
- can only implement [causal] or finite-time-delay semi-causal filters.

[causal]: http://en.wikipedia.org/wiki/Causal_system
