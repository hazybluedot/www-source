---
title: Interface and Structure
kind: activity
---

## Announcements

- questions about the midterm
- quiz feedback/discussion
- final project reminder

## Filters

- [Filter Interface and Structure](/activities/inclass_week10_1/)

## More Interface Patterns

### `ed` pattern

Examples: `bash`, `bc`, text-based adventure games

A main loop with a nested read/interpret/execute/output pattern.

~~~~ c
int main(int argc, char *argv[]) {
    /* variable declarations */

    /* command line argument parsing */

    while (/* not stopped */ ) {
        /* read and deserialize command string */
        /* execute control structure */
        /* serialize and write output */
    }

}
~~~~

### Roguelike Pattern

Similar structure to `ed` pattern, but the output step involves
redrawing the entire screen instead of printing lines. Programms with
this pattern usually imploy an external library such as
[ncurses](http://en.wikipedia.org/wiki/Ncurses) to handle the
mechanics of painting the screen.

Examples: `vim`, ASCII-drawn games

~~~~ c
int main(int argc, char *argv[]) {
    /* variable declarations */

    /* command line argument parsing */

    /* initialize screen buffers */

    while (/* not stopped */ ) {
        /* read and deserialize command string */
        /* execute control structure */
        /* control structure used to update image buffer */
        /* repaint screen */
    }
}
~~~~

### Separate Engine and Interface Pattern

Examples: `gitk`, games with a GUI

Server structure

~~~~ c
int main(int argc, char *argv[]) {
    /* variable declarations */

    /* command line argument parsing */

    /* establish listener */

    
    while (/* not stopped */ ) {
        /* wait for client connection */
        /* fork (if multi-client environment) */
        
        /* read and deserialize message from client */
        /* execute control structure */
        /* serialize result and send message to client */
    }
}
~~~~

## A Simple Makefile

~~~~ make
wordfreq: main.o
    clang -o wordfreq main.o -lanalytics
~~~~
