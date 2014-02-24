---
title: Introduction to git
kind: activity
requires: { background: [ vcs/intro, vcs/git/intro ] }
provides: { practice: vcs/git/intro }
tags: [ 'inclass' ] 
---

We are going to make some changes to our earlier `tolower` program to
make it more of a general-purpos character transliterator.  Since we
know what we have works, we would like a way to save that state and
keep track of any subsequent changes. We will use `git` for that
purpose.

## Configure git

This is just a one-time step (repeated for each separate machine you
plan to use `git` on). Follow the
[First-Time Git Setup](http://git-scm.com/book/en/Getting-Started-First-Time-Git-Setup)
instructions at least through the Your Identity section. You may chose
to follow the next step, "Your Editor" if you would like to use a
different editor to write commit messages other than the default
(`vim`, unless you have your EDITOR environment variable set to
something different).

## Initialize a new repo

I am going to name my new git project `motr`, for "My Own tr" in
reference to the Unix `tr` command. All this means is that the name of
the new directory that `git` initilizes will be named `motr`. The name
isn't used anywhere else in the git configuration, so you can easily
rename the directory later if you need to.

    $ git init motr

You should now have a new sub directory named `motr`, run `ls` to
confirm and then change into your new directory.

    $ cd motr

If you run `ls`, you will see there are no output, but if you run `ls -a` you should see a directory named `.git`

    $ ls -a
    .  ..  .git

This is where `git` will store all of its information about the
content you ask it to track. Typically you should avoid modifying any
files in the `.git` directory manually, let `git` do this for you. But
it is helpful to be reminded that like most Unix-inspired utilities,
`git` stores its configuration and settings in a plain text format
that you can view and edit with any text editor, if you need to.

## Copy the original `tolower.c` source file

Since I want to start with what I had done in `tolower.c` I will copy that file into my new repository and rename it `motr.c`

    $ cp ../tolower/tolower.c ./motr.c

you may have to adjust the source path `../tolower/tolower.c` if your
directory structure isn't the same as mine. The `..` in the path means
the parent directory. If my current working directory is
`~/ece2524/motr` then `../tolower` would refer to a directory at
`~/ece2524/tolower`.

## Tell `git` to track changes

`git` does not automatically track files in a git-managed
directory. This is because you will often have files in a git-managed
directory that you do *not* want to track, so `git` expects you to
explicity tell it which files it should track.

    $ git add motr.c

we have just told `git` to add the `motr.c` file to the staging area.
This means that it will be added to the git repository on the next
commit. You can run `git status` at any time to get a summary of what
files are staged for commit.

    $ git status
    # On branch master
    #
    # Initial commit
    #
    # Changes to be committed:
    #   (use "git rm --cached <file>..." to unstage)
    #
    #       new file:   motr.c
    #

Notice that `git` will often provide helpful hints in its output about
how to correct potential mistakes. For instance, if you hadn't
intended to add `motr.c` to the staging area `git` tells you you can
use the command `git rm --cached <file>` to unstage a file.

## Make the first commit

    $ git commit -m "Initial Commit"

Using the `-m` option will cause `git` to commit the changes using the message you supply after the `-m` option. To encourage detailed commit messages it is recommended to only use this short cut for the initial commit of a repository. Without the `-m`, `git` will open your default editor for you to write in a commit message.  The convention is to follow the following format:

    A short, descriptive title in the present tense

    A more detailed paragraph. Keep both the title
    and lines in the paragraph at 72 characters or
    fewer.

