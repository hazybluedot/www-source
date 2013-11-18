---
title: Ranged Loops
provides:
 - background: [ ranged_loops ]
---

## Repetitive Tasks

Computers are good at repeating a calculation over and over
again. Many programs we wish to write boil down to something like

~~~~
for each 'thing' in a collection of things
   do something with 'thing'
~~~~

Whether we wish to do something to each pixel in an image, each byte
in a stream, or each line in a text file, the idea is the same.

## Implementing Loops in C

If you are coming from a C/C++ background when you think about
performing some action on each element of an array you probably think
of something like this:

~~~~ c
int primes[5] = { 2, 3, 5, 7, 11 };

for(int n=0; n < 5; ++n) {
     printf("%d\n", primes[n]);
}
~~~~

Note that this and all the following examples will require compiling
using the C99 standard. If your compiler complains you may need to
explicitly tell it to use C99, if you are using `gcc` or `clang` this
can be accomplished with the `-std=c99` command line argument.

While this example certainly works and probably looks very familiar to
you, it has some notable weaknesses:

- the use of an extra variable `n`
- repeated knowledge of the number of things in the list (violation of SPOT)
- misleading use of the `[]` random access operator

we could eliminate some of the confusion by eliminating the index
variable and using a pointer

~~~~ c
int primes[5] = { 2, 3, 5, 7, 11 };

for(int *prime=primes; prime < primes+5; ++prime) {
    printf("%d\n", *prime);
}
~~~~

and we could go a step further and tell the compiler to compute the
end address for us

~~~~ c
int primes[] = { 2, 3, 5, 7, 11 };

for(int *prime=primes; prime < primes+(sizeof(primes)/sizeof(int)); ++prime) {
    printf("%d\n", *prime);
}
~~~~

though we pay for this convenience in the form of extra typing and
harder to read stop condition we will reap the benefits of the SPOT
rule if we ever decided to add or remove primes from our list.

What are examples are approaching is an implementation of
ranged-loops: a generic way to perform an action on each thing in a
collection of things.

## Ranged Loops in C++11

The limitations of C don't allow for anything as elegant as we might
see in a higher level language such as Python or Ruby, though if we
are working with the new C++11 standard we can get pretty close using
[STL containers](http://www.cplusplus.com/reference/stl/) and the new
`auto` keyword:

~~~~ c
vector<int> primes = { 2, 3, 5, 7, 11 };

for ( auto prime : primes ) {
    cout << prime << endl;
}
~~~~

To make the comparison to the C code easier the preceding example
assumes `using namespace std` and the necessary includes.  Note the
semantic advantages of the C++11 code over the C examples:

- The type `int` is only specified in one place
- The type of data does not need to be explicitly known in the body of the loop
- The start and stop conditions are inferred automatically by the compiler
- Only variables that are actually needed are declared
