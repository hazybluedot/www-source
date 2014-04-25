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

- [Setup remotes for wordfreq](/reading/wordfreq_gitsetup/)

## Graphical representation

It can be confusing to keep track of all the different remotes, forks, repo names, user1s and user2s.  This picture should help.  `user1` is `rflowers` and `user2` is `spilgrim`.

![Git Remotes](/assets/images/git_remotes.svg "remote associations")
