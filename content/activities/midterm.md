---
title: Start the Midterm
kind: activity
---

## Contents
{:.no_toc}

* table of contents
{:toc}

# Logistics

You may start the midterm at any time between *8am and 11:59pm
Wednesday, March 26, 2014*.  You will have 60 minutes to complete the
test from the time of the initial fork.

# General Notes

## Available Resources

Like other assignments you may use any online or offline resources
available to you (open note/open book).  Unlike other assignments you
may not work together or aid each other in the completion of this
exam.

## Formatting

When asked to type a command after verifying the command works as
expected in your terminal, type the command after the '$' for the
corresponding question. Ensure that there is a blank line immediately
before and after the command. e.g.

~~~~ text
$ od -c <somefile.txt
~~~~

When asked for a free-form response, write your response after the '>'
character for the given question. If your response spans multiple
lines, prepend each line with an additional '>' character. Be sure to
leave an empty line before and after your response. e.g.

~~~~

> this is a
> multiline
> free-form
> response

~~~~

In both command and free-form cases there may be additional white
space before the '$' or '>' character:

~~~~
1. When placed after numbered items
 
        $ od -c <somefile.txt

2. The '>' may be indented like this

    > this is a
    > multiline
    > free-form 
    > response

3. Yet another question...
~~~~

In general, just start your answer to the right of the prompt
character '$' or '>', depending on the question. Questions that do not
have a prompt character don't require a written answer, just perform
the action described. For example

~~~~
1. create a new directory named `output`

2. Run a command that will copy the file `files/afile.txt` to a
   file named `output/afile.txt`, type that command here:

   $
~~~~

Question 1 asks you to perform an action, run the command necessary
to create a directory named `output`, but you don't need to write the
command in the README file.  Question 2 asks you to run a command AND
write the command that you ran after the `$` prompt.


## File paths

All relative paths, unless otherwise noted, are relative to the base
directory of the cloned midterm. e.g. if you clone the repository to
`/home/rflowers/ece2524/midterm` and the README file refers to
`files/afile.txt` then the full path to that file would be
`/home/rflowers/ece2524/midterm/files/afile.txt`

## Use the manual

Remember to use the `man` command to view information for a particular
command. If a question asks for something that sounds complicated it's
likely there is a command line option that makes the task simple. I
will be sure to word the question in such a way that it contains a
search phrase you can use to quickly find the command line option in
the man page, so be comfortable searching a man page for a particular
phrase (press, '/', then type the search phrase and press 'Enter'.
Pressing 'n' will cycle to the next occurrence of the phrase, while
'N' will cycle to the previous occurrence).

## Compiling programs

You do not need to know about Makefiles, however, I will include one
for the programming section which will allow you to run the command
`make` to compile the source file into working program that you can
test. You should still know the commands to compile an object file and
link it to create a working program yourself if asked.

# Taking the test

## Fork and clone

The test is started once you fork the `midterm` repository:

~~~~ console
$ ssh git@ece2524.ece.vt.edu fork midterm <cvl_username>/midterm
~~~~
{: .command-syntax .no-explain}

replace `cvl_username` with your own username.

Clone a local copy of your forked midterm:

~~~~ console
$ git clone git@ece2524.ece.vt.edu:<cvl_username>/midterm.git ~/ece2524/midterm
~~~~
{: .no-explain}

Note that `~/ece2524/midterm` is the destination path for the clone.
If this directory already exists for some reason you will get an error
telling you that, in that case, just clone to a different directory
name, it doesn't matter what you call it as long as you know what it
is.

Change your working directory to the cloned midterm repo, open the
file `README.md` in you favorite text editor. You will edit this file
to include your answers to the questions asked.

~~~ console
$ cd  ~/ece2524/midterm
~~~~
{: .no-explain}

## Submission

The test is submitted when you run `git push` to push any changes you
made to the repository.  Be sure to `add` and `commit` any modified
files, including the `README.md` file itself before doing the final
`push`.


### Feedback

Unlike the past couple programming assignments, detailed tests will
not run at the time of submission.  The response from the 'git push'
command will contain the time elapsed since you forked the midterm as
well as a list of commits you made since then. Here is an example
response for the user `rflowers`

~~~~
$ git push
Counting objects: 5, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 372 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
0 hours, 2 minutes, 12 seconds since fork
Commits received:
<rflowers@local> finish part 1
To git@ece2524.ece.vt.edu:rflowers/midterm.git
   2792135..0804d6e  master -> master
~~~~

If you see the message

~~~~
Warning: no commits since fork.
~~~~

this means that you are pushing an unmodified midterm fork.

You can verify what you submitted by cloning a copy into a new
location:

~~~~ console
$ git clone git@ece2524.ece.vt.edu:<cvl_username>/midterm.git ~/verify/midterm
$ cd ~/verify/midterm
$ git log
~~~~
{: .command-syntax .no-explain}

check that the `README.md` contains all your answers and check that
the source code for the programming part contains all your
modifications.
