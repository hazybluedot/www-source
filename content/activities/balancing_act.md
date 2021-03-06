---
title: Balancing Act
kind: activity
requires: { background: [ balanced_brace_algorithm, c/argv ] }
tests:
  - type: bonair
    feature: features/balanced
    tags: [ compile, part1 ]
repos: 
    - user: USER/balanced
compile_to: balanced
---

# Introduction
 
Let's design our first full Unix-style command line utility. Since a
large number of you have had some experience with checking a string
for balanced parenthesis or curly braces we will use that idea as a
starting point.

# Program Behavior
1. What type of input should our program accept?

   A list of files given on the command line, or if no files are given, then read from /standard input/. See ~grep~ as an example.

  
2. What output will it give and how will it be formatted?

   The C and C++ compiler provides a good example to follow: print the output in an easily parsed, structured formate that contains all the information available:

   ~~~~ text
   file_name:line_number:column_number: description of error
   ~~~~

   for example

   ~~~~
   test1.c:7:1: unmatched closing brace
   ~~~~

  If there are *no* balancing errors then the program should not produce any output. [[http://www.catb.org/esr/writings/taoup/html/ch01s06.html#id2878450][Silence is Golden]].

3. What kind of errors might be encountered?

   1. How will our program detect them?
   2. How will our program handle and report them?

# Getting Started
Once we have decided how our program should work and have written
up some test cases we can start coding. You may choose to use write in C or
C++[^nonc]

## Initialize a new git repository

[initialize a new git repo](git_init) and [add a remote](git_remote_add)

### Start Coding
1. Start simple. Write an empty ~main()~ function and compile it.
2. Write a simple `Makefile` that will compile a program named
   `balanced` when `make` is run.
3. Get in the habit of working in short code/compile cycles. Using
   ~make~ it is easy to quickly build a project and check for
   errors. It is usually easier to find and fix compile errors soon
   after they were introduced into the code rather than waiting until
   even more lines and potentially more errors are introduced.
4. commit often.  git makes commits cheap and easy. Use them
   judiciously. As a rule of thumb, make a commit each time you make a
   change that results in a successfully compiling project. 

### Useful libraries and macros

Remember, when listing library calls that have man page entries I will
use the format `function(N)` where `N` is an integer cooresponding to
the manual section the function is defined in.  To view the manual
page for `fopen(3)` you would run `man 3 fopen`

- C++
  - Data structures
    
    check out the [standard containers] provided by the STL.
  - files streams 

    The [fstream] header provides [ifstream] and [ofstream] for input/output
    file streams, respectively.  [std::cin], [std::cout] and
    [std::cerr] are the streams provided for *standard input*, *standard
    output* and *standard error*.

    The [std::istream::get] method can be used to extract the next
    character from an input stream.

- C
  - Data structures
    
    you may find the `queue(3)` macros useful for implementing lists/stacks
  - file streams

    See the manual pages for `fopen(3)`, `fclose(3)`, `fgetc(3)`

[std::istream::get]: http://www.cplusplus.com/reference/istream/istream/get/
[standard containers]: http://www.cplusplus.com/reference/stl/
[fstream]: http://www.cplusplus.com/reference/fstream/
[ifstream]: http://www.cplusplus.com/reference/fstream/ifstream/
[ofstream]: http://www.cplusplus.com/reference/fstream/ofstream/
[std::cin]: http://www.cplusplus.com/reference/iostream/cin/
[std::cout]: http://www.cplusplus.com/reference/iostream/cout/
[std::cerr]: http://www.cplusplus.com/reference/iostream/cerr/

### Tips
- If you have trouble understanding how `argc` and `argv` are used,
  try writing a simple program that simply prints out the arguments
  provided on the command line:

  ~~~~ c
  #include <stdio.h>

  int main(int argc, char* argv[])
  {
        int n;

        for(n=0; n < argc; ++n)
        {
                printf("argv[%d]: %s\n", n, argv[n]);
        }
        return 0;
  }
  ~~~~

  compile it and run it with a few different arguments to see how the
  argv array works.

[^nonc]:
    if you have a compelling reason to write in something other than C/C++ let me know well in advance so I can get the necessary build tools on the server.
