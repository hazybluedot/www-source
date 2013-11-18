---
title: Script Work
kind: activity
tests:
  - type: bonair
    feature: features/scriptwork
language: [ Python, Shell ]
repos:
  - user: USER/scriptwork
---

## Background
- [Ranged Loops](/reading/ranged_loops/index.html)
- [Python Collections](/reading/python_collections/index.html)

## Reading and Parsing Lines

## Process a list of key/value pairs

Given an input file consisting of a list of key/value pairs separated by a colon:

~~~
key1:value1
key2:value2
key3:value3
~~~

1. Write a shell scrip named `types.sh` that reads data in this format from *standard input* and prints lines to *standard output*
   - translate the `:` to a space character and then utilize the
     `read` utility's ability to split words into separate variables
2. Write a Python script named `types.py` that reads data in this format from *standard
input* and prints lines to *standard output*

See the [Testing](#testing) section for expected output formatting.

## Helpful Python Tips

### Formatting strings:

~~~~ python
>>> "this is a {0} string".format("formatted")
'this is a formatted string'
>>> "for each {thing} in {things}".format(thing="pixel", things="an image")
'for each pixel in an image'
~~~~

### List expansion

~~~~ python
>>> first, second, third = [ 'dog', 'cat', 'fish' ]
>>> first
'dog'
>>> second
'cat'
>>> third
'fish'
>>>
~~~~

### Splitting a String

~~~~ python
>>> "number = 5".split('=')
['number ', ' 5']
~~~~

with list expansion:

~~~~ python
>>> label, value = "number = 5".split('=')
>>> label
'number '
>>> value
' 5'
>>>
~~~~

### Stripping Whitespace

~~~~ python
>>> "    a string with leading and trailing white-space     ".strip()
'a string with leading and trailing white-space'
~~~~


