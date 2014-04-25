---
title: High Level Program Structure
kind: activity
provides: { background: [ 'ipattern/catlike', 'ipattern/filter' ] }
---

## High Level Program Structure

- serialize/marshalling: transform a stream of bytes to in-memory data structures
- deserialize/demarshalling: transform in-memory data structures to a stream of bytes

![High Level Structure](/assets/images/program_highlevel_structure_small.svg)

[full screen](/assets/images/program_highlevel_structure.svg)

## Code Structure

Common
[Unix interface design patterns](http://www.catb.org/esr/writings/taoup/html/ch11s06.html)
have common code structures associated with them.

### The Filter Pattern

Read data on standard input, transform it in some way, and write the
results to standard output

#### Standard Variation

when output can be produced after reading a single item

*Examples*: `tr` (by character), `grep` (by line)

~~~~ c
int main(int argc, char *argv[]) {
    /* variable declarations */

    /* CLA parsing */

    while (( /* deserialize one item */ ) != EOF) {
        /* central algorithm */
        /* serialize one item */;
    }
}
~~~~

#### Sponge Variation

when all data must be read before any output can be produced

*Examples*: `sort`, `wc`, `wordfreq`

~~~~ c
int main(int argc, char *argv[]) {
    /* variable declarations */

    /* CLA parsing */

    while (( /* deserialize one item */ ) != EOF) {
        /* insert item into data structure */
    }

    /* central algorithm */
    /* serialize list of items */;
}
~~~~

## `catlike` pattern

Some filters can read input from a list of files named on the command
line instead of reading from *standard input*
Examples: `cat`


~~~~ c
int main(int argc, char *argv[]) {
    FILE* fp;
    /* variable declarations */

    /* CLA parsing */

    if ( /* there are file name arguments */ ) {
        while ( /* there are still file names in argv */ ) {
            fp = fopen(...);
            /* filter pattern using fp as input */
        }
    } else {
        /* filter pattern using standard input as input */
    }
}
~~~~

Note: A `catlike` filter pattern may utilize the
[standard variation](#standard-variation) or the
[sponge variation](#sponge-variation).
