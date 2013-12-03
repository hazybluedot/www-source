---
title: Gitolite Command Reference
---

# Contents
{:.no_toc}

* Table of Contents
{:toc}

## What is `REPO`?

I will use `REPO`,`SRC_REPO` or `DEST_REPO` to stand in for a
particular git repository in the following commands. Replace it with
an actual repo. For instance, if your git user is `rflowers` then
`rflowers/balanced` would be the `REPO` for your [Balanced Brace
Checker](/activities/balancing_act/) project.

## Clone a repo

~~~~ console
git clone <%= config[:git_url]%>:REPO
~~~~

- This will work only if you have read permission on `REPO`

## Fork a repo

~~~~ console
ssh <%= config[:git_url]%> fork SRC_REPO DEST_REPO
~~~~

- You will get an error if you do not have read permission on `SRC_REPO` or create permission on `DEST_REPO`
- You will get an error if `DEST_REPO` already exists (e.g. you already forked to this destination)

## Check your test results for an activity

~~~~ console
ssh <%= config[:git_url]%> show_results REPO
~~~~

### Check your test results for all activities

You can easily write a shell script to run the preceeding command
repeatedly with different values of `REPO`:

~~~~ bash
#!/bin/sh

repos="fdtest redir cxxstack balanced scriptwork project"
gituser="<your git username>"

for repo in $repos
do
    ssh ece2524git@ece2524.ece.vt.edu show_results $gituser/$repo
done
~~~~

1. Adjust the value of `repos` and `gituser` according to your needs.
2. Set the execution bit, then run your script!
3. Profit!?

## Delete a repo

### Warning

Be careful with this command, be sure you know that you *need* to
delete a repo before considering this. Most problems with remotes can
be fixed with non-destructive git commands.

Consider:
 - I can only see repos that exist on the server. These are used for
   grading purposes. Often times I will re-run the grading scripts
   even after an assignment has been graded once (for example, I make
   some changes to the tests that are run). If you delete a repo that
   is used for a graded assignment and don't replace it, the next time
   I refresh grades that particular assignment will register as a 0,
   even if it had already been graded previously.
 - There is often no good reason to "start from scratch" with a
   git-managed project. Use non-destructive git commands to manipulate
   files into the state that you want (e.g. `git add`, `git mv` or
   `git rm` and then `git commit`)

### Reasons you may need to delete a remote repo

- Likely the only reason you might ever need to delete a repo is if you ran a `fork` command and accidentally used the wrong SRC_REPO.

  ~~~~ console
  $ ssh <%= config[:git_url]%> fork user1/collab1 user2/collab2 # oh no, should have forked user1/collab2
  ~~~~

  Now, `user2/collab2` exists, so if you try to fork the correct
  source, `user1/collab2` you will get an error. In this case, it is
  safe to delete `user2/collab2`

  ~~~~ console
  $ # delete user2/collab2 (see below)
  $ ssh <%= config[:git_url]%> fork user1/collab2 user2/collab2 # oh no, should have forked user1/collab2
  ~~~~

- `git` is a distributed version control system, every clone of a repo
   contains the entire history of the project, there is nothing
   special or magical about repos stored on a remote server. Therefor,
   assuming you have a local clone of REPO, and somehow the remote
   copy becomes corrupted (this is very rare, but can happen), you may
   need to delete the corrupted remote repo and then push back your
   local copy.

  ~~~~ console
  $ cd ~/ece2524/REPO
  $ git status # make sure your local copy is up-to-date
  $ # delete remote REPO (see below)
  $ git push -u origin master # recreate remote REPO
  ~~~~

### Are you sure you want to delete a repo?

1. unlock the repo, allowing it to be deleted

   ~~~~ console
   $ ssh <%= config[:git_url]%> D unlock REPO
   ~~~~

2. delete it. There is no going back after this!

   ~~~~ console
   $ ssh <%= config[:git_url]%> D rm REPO
   ~~~~
