---
title: "PyFreq: Python implementation of word frequency count"
kind: activity
provides: { practice: [ modularity, python ] }
requires: { background: [ python/types/list, python/types/dict ] }
tests:
  - type: bonair
    feature: features/pyfreq
    tags: [ part1 ]
repos:
  - user: 'USER/pyfreq'
---

## Python Implementation

Based on our current breif discussion of Python, you should have all
the tools needed to implement the Word Count program in Python with
the following caveats:

1. We haven't discussed sorting collections in Python, so the output
   may be printed in any order
2. Likewise, don't implement any command line argument parsing for now
   and assume the program will always read from *standard input*.
3. A [dict] is not a [sequence], so slicing ( the `[i:j]` syntax
   to get index items `i` up to `j` from a sequence) won't work
   directly on dictionary to limit how many lines of output
   are printed, so for now, just print *all* counted words, don't limit
   to 10 or any other fixed value.

[dict]: https://docs.python.org/3.3/library/stdtypes.html#mapping-types-dict
[sequence]: https://docs.python.org/3.3/library/stdtypes.html#sequence-types-list-tuple-range

The [code we wrote in class](/activities/inclass_week12_2/) is mostly
complete, though you will need to make a few changes:

1. modify the output format to match

   ~~~~ console
   $ ./pyfreq.py < numbers
   3 three
   1 one
   2 two
   4 four
   ~~~~
   {:.no-explain}

   but remember, line order doesn't matter and in fact you will
   probably get a different order each time you run the program.
   
2. Strip punctuation marks (`!`, `?`, `.`, `,`, `:`) from words
   so that, for example, given input

   ~~~~
   this line has punctuation marks!
   this line has punctuation marks.
   this line does not have punctuation marks
   ~~~~

   the program counts the word `marks` three times, instead of
   counting `marks!` once, `marks.` once and `marks` once.

   - Hint: see [`string.strip()`][string.strip]
   - Hint: In the [`string`][string] module there is a constant named [`punctuation`][string.punctuation]

     ~~~~ pycon
     >>> import string
     >>> print(string.punctuation)
     !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
     ~~~~
   
[string.strip]: https://docs.python.org/3.4/library/stdtypes.html#str.strip
[string]: https://docs.python.org/3.4/library/string.html
[string.punctuation]: https://docs.python.org/3.4/library/string.html#string.punctuation

## Considerations

- The tests will check for the existence of two files: `pyfreq.py` and
  `wordlist.py`
- The tests will check that `pyfreq.py` imports `wordlist` as a module
- The tests will check that the `wordlist.py` module contains test
  code that will read words from *standard input* and print the raw
  list obtained to *standard output*. The test code should run if
  `wordlist.py` is invoked from the command line, but not if it is
  imported by another file (Hint: just like we did [in class](/activities/inclass_week12_2/)).

  ~~~~ console
  $ echo "this is a list of words" > some_file
  $ python3 wordlist.py < some_file
  ['this', 'is', 'a', 'list', 'of', 'words']
  $ echo 'this, is. a? list: of (words)' > words_with_punct
  $ python3 wordlist.py < words_with_punct
  ['this', 'is', 'a', 'list', 'of', 'words']
  ~~~~
  {:.no-explain}
- The tests will check that `pyfreq.py` can be executed by name:
  - it's execution permission bit should be set
  - it should contain a valid '[shebang]' line specifying the python interpreter (read the "Portability" section of the linked wikipedia article to gain insight as to why we prefer `/usr/bin/env python3` instead of `/usr/bin/python3`)

[shebang]: http://en.wikipedia.org/wiki/Shebang_%28Unix%29
