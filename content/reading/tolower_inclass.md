---
title: "Write a simple `tolower` program"
provides: { background: examples/tolower.c, practice: patterns/stdio }
requires: { background: tools/editor_intro }
kind: reading
---

## Compile and Understand `tolower.c`

Starting with a file named `tolower.c` that we wrote in class:

~~~~ c
#include <ctype.h>
#include <stdio.h>

int main() {
    int c;

    while((c = getchar()) != EOF) {
        putchar( tolower(c) );
    }
}
~~~~

compile it

    $ clang tolower.c

and run it with your own input from the keyboard


~~~ console
$ ./a.out
:Hello World
hello world
:^d
~~~
{: .no-explain }

### Name your output program

We ma find it useful to compile multiple, separate programs in the same directory, and it would be quite confusing if they were all named `a.out`.  We can use the `-o` option with `clang` to supply  an output name:

~~~ console
$ clang -o tolower tolower.c
~~~

~~~ console
$ ./tolower
:Hello World
hello world
:^d
~~~
{: .no-explain }
