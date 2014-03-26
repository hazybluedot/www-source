---
title: Continuing with CLAs
kind: activity
provides: { background: 'cla/intro2' }
requires: { background: 'cla/intro' }
---

# Announcements

1. The "connection refused" issue has been resolved for now.

1. The `ece2524.ece.vt.edu` machine will go down today (Wednesday)
   around 1pm for maintinace.  Save all work and close all
   applications you have running before then. You will need to restart
   your tmux and weechat session when the machine comes back up
   (estimated downtime: 2 hours).

2. I will start to publish my "playground" programs under repos named
  `play/*`, the only one so far is `iocompare`
  
        $ git clone git@ece2524.ece.vt.edu:play/iocompare.git
        $ cd iocompare
        $ less README.md
  
   I will work on getting an index of these published on the website as
  well.  They will be small programs, many will probably be from
  [Advanced Programming in the Unix Environment](http://www.apuebook.com/code3e.html)
  as I continue to read more through it. They are not assignments, but
  meant to help gain an understanding of how programs you write
  interact with the kernel and the rest of the system. Explore at your
  leasure.

3. Posted on #vtluug this morning:
   [A lesson in shortcuts](https://plus.google.com/u/0/+RobPikeTheHuman/posts/R58WgWwN9jp)
   by Rob Pike

# Where we're headed

  - building libraries that we can use in future projects (like
    `analytics`)
  - building flexible, useful programs around those libraries

# Set up remotes for your partner's repo

There will be two users `user1` and `user2`.  Pick a role, it doesn't
matter who is who.

- `user1` grant read access to `user2`

      $ ssh git@ece2524.ece.vt.edu perms user1/wordfreq + READERS user2

- `user2` fork `user1`'s repo

      $ ssh git@ece2524.ece.vt.edu fork user1/wordfreq user2/forks/wordfreq

- `user2` clone a local copy of the fork

      $ git clone git@ece2524.ece.vt.edu:user2/forks/wordfreq.git ~/ece2524/wordfreq2

- `user2` add a remote `upstream`

      $ git remote add upstream git@ece2524.ece.vt.edu:user1/wordfreq.git
      
   This will add an entry named `upstream` in `user2`'s remote list


      $ git remote -v
      origin  git@ece2524.ece.vt.edu:user2/forks/wordfreq.git (fetch)
      origin  git@ece2524.ece.vt.edu:user2/forks/wordfreq.git (push)
      upstream        git@ece2524.ece.vt.edu:user1/wordfreq.git (fetch)
      upstream        git@ece2524.ece.vt.edu:user1/wordfreq.git (push)
      $

- `user1` make some changes

Have `user1` edit their code. Get a working implentation of using
`strtol` to parse `argv[1]` as an integer, for example. You can leave
off error checking for now.  Add and commit your changes, then push to your remote named `origin`

- `user2` pull updates from `upstream`

  Now, `user2` can pull in the changes that `user1` has pushed to their remote

      $ git pull upstream master

  Inspect the source in `main.c`, does `user2`'s copy look the same as `user1`'s?

- `user1` will want to also pull changes from `user2`

Since this will be a collaborative effort, at some point `user1` will
need to pull updates made by `user2` back into their own repo. They
will set up a remote refering to `user2`'s forked code

      $ git remote add user2 git@ece2524.ece.vt.edu:user2/forks/wordfreq.git

- Note: There was a typo earlier, if you already ran the previous
command with the incorrect url (`user1` instead of `user2`) run

  ~~~~ console
  $ git remote set-url user2 git@ece2524.ece.vt.edu:user2/forks/wordfreq.git
  ~~~~~
  {: .no-explain}

  to fix it
{: .notice}

## Graphical representation

It can be confusing to keep track of all the different remotes, forks, repo names, user1s and user2s.  This picture should help.  `user1` is `rflowers` and `user2` is `spilgrim`.

![Git Remotes](/assets/images/git_remotes.svg "remote associations")
