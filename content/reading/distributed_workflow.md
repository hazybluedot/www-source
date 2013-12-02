---
title: Distributed Workflow
---

## Background
{:.no_toc}
- [Distributed Git - Distributed Workflows](http://git-scm.com/book/en/Distributed-Git-Distributed-Workflows)

### Server Names
I will be using our ECE2524 server as the remote server here,
but the same steps work for any remote serve. For instance, GitHub
makes it very easy to fork a repo and issue pull requests back to
the original owner [^linus_pullrequest]

## Contents
{:.no_toc}

* Table of Contents
{:toc}

## Centralized Workflow

For small groups the centralized workflow may work well.  There is
only a single publically accessible repository and each member of the
team has push access.

### Add Writers
To add two additional writers, `user1` and `user2` to your gitolite
hosted repo (on the ece2524 server), e.g. `rflowers/scriptwork` you
can run

~~~~ console
ssh <%= config[:git_url]%> perms rflowers/scriptwork + WRITERS user1
ssh <%= config[:git_url]%> perms rflowers/scriptwork + WRITERS user2
~~~~

Check the permission list for the same repo with

~~~~ console
ssh ece2524 perms -l rflowers/scriptwork
~~~~

Note: this command will only show permissions you have added, it will
not list the read/write access of the owner since that is implied.

Now other memebers of your team can clone, pull and push from that
repo URL. 

### Add Collaborators to Github Repo

To add additional contributors to your [github](https://github.com/) repo

1. From the repo's home page, click "Settings" in the right side-bar.
2. Click on "Collaborators" in the left side-bar
3. In the text box, type in the github user of the person you want to add as a collaborator.
4. Click "Add"

## Integration-Manager Workflow

[^linus_pullrequest]: However, [Linus Torvalds does not use GitHub's pull request feature for the linux kernel](https://github.com/torvalds/linux/pull/17#issuecomment-5654674). It's a rather epic thread and fun to read if you have the time.

### Contributor

1. Make a publically readable fork of the repository you want to contribute to

        ssh <%= config[:git_url]%> fork MAINTAINER/project CONTRIBUTOR/project
    {: .language-console}

2. clone a local copy

        git clone <%= config[:git_url]%>:CONTRIBUTOR/project.git
    {: .language-console}

3. add an `upstream` remote

        git remote add upstream <%= config[:git_url] %>:MAINTAINER/project.git
    {: .language-console}

   You should now have at least two remotes (check with `git remote -v`):

   - `origin`:  which refers to your own publically accesible repo which you have read/write access to
   - `upstream`: which refers to the main project repo which you can read from but not write to.

4. make your changes to your local copy, add and commit as needed.
5. push your local changes to your own remote repo (`origin`).
6. Send an email to MAINTAINER requesting that they pull your changes, make sure to provide your publically readable repo url.
7. MAINTAINER may request that you handle any merge conflicts if they occur. 

### Maintainer

Upon recieving a pull request from CONTRIBUTOR

1. If this will be a regular CONTRIBUTOR it probably makes sense to
   add a remote for CONTRIBUTOR

   ~~~~ console
   git remote add CONTRIBUTOR CONTRIB_URL
   ~~~~

   Where CONTRIB_URL is the URL to the contributor's public repo.
   
2. Merge the contributor's changes locally

   ~~~~ console
   git pull CONTRIBUTOR
   ~~~~

## Activities
- [Planets](/activities/collaboration/)
