---
title: "More Python"
kind: activity
provides: { background: [ python/types/list, python/types/dict ] }
---

## From Last Class

- In Python there is
  [no difference](https://docs.python.org/3/reference/lexical_analysis.html#strings)
  between `"string"` and `'string'`
- [String concatination](https://docs.python.org/3/reference/lexical_analysis.html#string-literal-concatenation) can be performed without the `+` operator:

  ~~~~ pycon
  >>> "hello " 'world'
  'hello world'
  ~~~~

## Some basic data structures

- [tuple]: heterogeneous ordered collection

  ~~~~ pycon
  >>> import sys
  >>> mytuple = ( 5, 'five', sys.stdout)
  ~~~~

- [list]: homogeneous ordered collection

  ~~~~ pycon
  >>> mylist = [ 1, 2, 3, 4 ]
  ~~~~

- dictionary ([dict]): collection of name, value pairs

  ~~~~ pycon
  >>> mydict = { 'five': 5, 'two': 2, 'seven': 7 }
  ~~~~

## Data operations

- [strings][str-methods] can be [split][str.split] into lists
- [lists][list] and [tuples][tuple] are [sequence] types and can be indexed and sliced
- [dictionaries][dict] can be converted to lists of tuples

[dict]: https://docs.python.org/3.3/library/stdtypes.html#mapping-types-dict
[list]: https://docs.python.org/3.3/library/stdtypes.html?highlight=list#list
[tuple]: https://docs.python.org/3.3/library/stdtypes.html?highlight=tuple#tuple
[sequence]: https://docs.python.org/3.3/library/stdtypes.html#sequence-types-list-tuple-range
[str-methods]: https://docs.python.org/3.3/library/stdtypes.html#string-methods
[str.split]: https://docs.python.org/3.3/library/stdtypes.html#str.split

## Count Words

- split input into list of words, add each word to a dictionary with
  the word as the key and the number of occurances is the value

## Source

- wordlist.py

  ~~~~ python
  #!/usr/bin/env python3

  def word_list(stream):
      mywords = []
      for line in stream:
          for word in line.split():
              mywords.append(word)

      return mywords

  if __name__ == '__main__':
      from sys import stdin

      print(word_list(stdin))
  ~~~~

- pyfreq.py

  ~~~~ python
  #!/usr/bin/env python3

  import wordlist as wl
  from sys import stdin,stdout

  words = {}

  for word in wl.word_list(stdin):
      try:
          words[word] += 1
      except KeyError:
          words[word] = 1

  for key in words:
      print("{0}: {1}".format(key, words[key]))
  ~~~~


## Homework

[PyFreq Part 1](/activities/pyfreq_part1/)
