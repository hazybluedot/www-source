---
title: Final Project Reviews
kind: activity
tests:
 - type: bonair
   feature: features/project_review
repos:
 - user: USER/reviews/TAG
---

# Contents
{:.no_toc}

* Table of contents
{:toc}

## Introduction

Create a new git repository for your review.  Name it based on the tag
of the project you are reviewing. In the following examples replace
`USER` with your git username and `TAG` with the tag for the project
you are reviewing.

### Initializing a git repo

~~~~ console
$ git init ~/ece2524/reviews/TAG
$ cd ~/ece2524/reviews/TAG
$ git remote add origin <%= config[:git_url]%>:USER/reviews/TAG
~~~~

Create a file named `REVIEW.md`, the first few lines should be

~~~~ text
---
title: A descriptive title of your review
tag: TAG
---
~~~~


adjusting the title and `TAG` as appropriate. The rest of the file you
may format with
[markdown](http://daringfireball.net/projects/markdown/syntax).

### Crash course in markdown

For example:

~~~~ text
# This is a level one header

A very short [markdown](http://daringfireball.net/projects/markdown/syntax) file.

This is a paragraph.

## A level 2 header

Here is a nice list:

- item 1
- item 2
~~~~

## Writing the Review

Your review should contain at least three sections: Usage, Style and
Philosophy, covering the following general considerations. Feel free
to elaborate!

### Usage

1. Are there sufficient instructions in the `README` to get started?
   - compiling (if necessary)
   - executing
   - using
2. Does the program compile (if applicable) and run without any errors?
3. Does the program work as advertised?

### Style

Take a look at the source code, starting with the entry
point.

- Is it well organized? Can you read through it and have a general
  idea of what each part should be doing based on class, function and
  variable names?
- Is it modular? Do the different sections encapsulate a singly
  clearly defined aspect of the program? For example, if the program
  reads settings in from a configuration file is there a separate
  module that parses the text configuration file into a data
  structure, and another module that accepts the configuration data
  structure and does something with it?

### Philosophy

Think about both the usage of the program, and the code
structure. Does this project embody the Unix design philosophy? How or
how not? Are there any changes the developers could make to make the
project more "Unixy"?


## Example REVIEW.md

Here is a sample review. Adjust the title and tag as appropriate.  Be
detailed.  Link to more information where appropriate.

~~~~ text
---
title: Review of a very awesome project
tag: very_awesome_project
---

## Usage

The
[very awesome project](https://github.com/joehacker/very_awesome_project)
was very awesome to use. The `README` provided clear instructions to
get started, after cloning the project I just ran:

    $ make
    $ ./very_awesome

and was good to go!

## Style

The code was well organized, there was a very clean separation between
the `widget` module and the `sprocket` module. However, the `foo` module could have been better organized:

- refactor the `bar` functionality out into a separate module
- use a more consistent naming scheme, for example, the foo getter is named `get_foo` but the setter is `fooSet`

## Philosophy

Dennis Ritchie would be proud, this project was very Unixy.

- it exhibited a strong single center: the `foo` algorithm was the
  core of the program while the `widget` and `sprocket` modules
  provided a thin interface wrapper to the algorithm
- the output of the program was clean and simple, suitable for use in
  a pipeline

However, there is still room for improvement:

- Changing the `-s` flag to `-f` would be more consistent with other
  command line utilities ([Rule of Least Surprise](http://www.catb.org/esr/writings/taoup/html/ch01s06.html#id2878339))
- There is no error checking on the return of `get_foo`. If this call
  fails, it may cause unexpected and hard-to-debug behavior. Check for
  all error conditions and print a message to /standard error/ and
  exit immediately if it doesn't make sense to continue
  ([Rule of Repair](http://www.catb.org/esr/writings/taoup/html/ch01s06.html#id2878538))

~~~~
