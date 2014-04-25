---
title: "Git Workflow for wordfreq"
kind: reading
---

## Set up remotes for your partner's repo

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

## Summary

Both `user1` and `user2` should be able to read/pull from the other's repository

- `user1` has read access to `user2/forks/wordfreq`
- `user2` has read access to `user1/wordfreq`

- `user1` has a remote named `origin` with repo name `user1/wordfreq`
- `user1` has a remote named `user2` with repo name `user2/forks/wordfreq`

- `user2` has a remote named `origin` with repo name `user2/forks/wordfreq`
- `user2` has a remote named `upstream` with repo name `user1/wordfreq`

## Workflow

- setup
  ![Git Remotes](/assets/images/git_remotes.svg "remote associations")

- independent work
  ![Git Remotes](/assets/images/git_collab_workflow_independent.svg "independent work")

- merge
  ![Git Remotes](/assets/images/git_collab_workflow_merge.svg "merge work")

## Used By

- [`wordfreq` part 2](/activities/word_count_part2)
- [`wordfreq` part 3](/activities/word_count_part3)
