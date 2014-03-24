---
title: Practice Midterm
---

## Dates

The midterm will be available all day on Wednesday, March 26.  You
will have 1 hour to complete it from the time you start. The proceure
for the real midterm will be identical to the one used to obtain and
submit the practice. The only difference will be the repository names.

## Practice

There are two practice midterm repositories available to you,
`midterm/practice1` and `midterm/practice2`.

- Fork the midterm

  ~~~~ console
  $ ssh <%= config[:git_url] %> fork midterm/practice1 <cvl_username>/midterm/practice1
  ~~~~
  {: .command-syntax .no-explain}

  The digit `1` in the destination `<cvl_username>/midterm/practice1`
  could be any digit between 1-9.  You can take advantage of this fact
  to take the practice midterm more than once.
  
- Clone a local copy

  ~~~~ console
  $ git clone <%= config[:git_url] %>:<cvl_username>/midterm/practice1.git ~/ece2524/practice_midterm1
  ~~~~
  {: .command-syntax .no-explain}

  Note, you can change the destination '~/ece2524/practice_midterm1`
  to be anything you like, in particular, you can fork and clone
  either practice exam any number of times putting each into a
  different destination directory to practice the procedure.
  
- Change directory and view README

  ~~~~ console
  $ cd ~/ece2524/practice_midterm1
  $ less README.md
  ~~~~
  {: .no-explain}

## Solutions

I have made solutions to the two practice midterms available at repos
named `solutions/midterm/practice1` and `solutions/midterm/practice2`,
respectively.  To view the solutions, clone the repo, e.g.

    $ git clone git@ece2524.ece.vt.edu:solutions/midterm/practice1 ~/ece2524/solutions/practice1

change directory to the one created by the clone

    $ cd ~/ece2524/solutions/practice1

and view the `README.md` for the solutions to the command-related
questions and the relevent source files for the programming solutions.

In both solution repositories I have included a file named
`part1.transcript` which contains the commands I ran for the "Files
and File System" section.

To compile the programing solutions change directory in into the
appropriate sub directory (`yawc` for `practice1` and `mailgrep` for
`practice2`) and run the `make` command

    $ cd yawc
    $ make

You should then have a compiled binary named either `yawc` or
`mailgrep` depending on which solution you compiled. To exercise the
program there are some sample input files in the `files` directory of
the repo. Assuming your current working directory is the one
containing the source files and the compiled binary, try the following test cases

    $ ./mailgrep ../files/*.txt
    $ ./mailgrep ../files/file1.txt not_a_file ../files/file2.txt
    $ cat ../files/*.txt | ./mailgrep

or

    $ ./yawc ../files/*.txt
    $ ./yawc ../files/afile.txt not_a_file ../files/some_file.txt
    $ cat ../files/*.txt | ./yawc

*Note:* As I mentioned in class, both these programs ask you to read
open command line arguments as file names. We haven't talked about
this yet in class, for the midterm I will only expect you to be able
to read from standard input, so both the practice programs are a bit
more complex then anything that will be on the midterm this semester.
