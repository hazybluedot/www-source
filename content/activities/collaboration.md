---
title: Collaboration with git
kind: activity
---

## Background
{:.no_toc}

- [Distributed Workflows](/reading/distributed_workflow/)
- [Record Jar Parser](/reading/record_jar/)

# Contents
{:.no_toc}
* Table of Contents
{:toc}

## Activity

Working in pairs, practice using both a
[centralized workflow](/reading/distributed_workflow/#centralized-workflow)
and an
[integration-manager workflow](/reading/distributed_workflow/#integration-manager-workflow).
Each person will contribute a single file to a shared repository.

### Centralized Workflow

Pick one person to be the creator of the shared repo, this person will be named MAINTAINER. Use `MAINTAINER/collab1` as the remote repo name. There should be only one `MAINTAINER/collab1` on the server. The other person call be called CONTRIBUTOR.
  
- The MAINTAINER shall initialize a new local repository and
  add/commit the file for [User1](#user1)
- The MAINTAINER shall add a remote named `origin` with url `<%= config[:git_url]%>:MAINTAINER/collab1.git`
- The MAINTAINER shall do an initial commit to `origin`

  ~~~~ console
  git push -u origin master
  ~~~~

- The MAINTAINER shall [add write access](/reading/distributed_workflow/#add-writers) to `MAINTAINER/collab1` for CONTRIBUTOR
- The CONTRIBUTOR shall clone `<%= config[:git_url]%>:MAINTAINER/collab1.git`
- The CONTRIBUTOR shall add/commit the file for [User2](#user2)
- The CONTRIBUTOR shall merge there changes with the remote

  ~~~~ console
  git push origin master
  ~~~~

### Integration-manager Workflow

Each user will have their own remote named `USER/collab2`.

- Decide who will be the MAINTAINER and who will be a COLLABORATOR.
- The MAINTAINER shall initialize a local repository first
- The MAINTAINER shall add a remote name `origin` with the url `<%=
  config[:git_url]%>:MAINTAINER/collab2`

- The MAINTAINER shall push to `origin`

  ~~~~ console
  git push -u origin master
  ~~~~

- The CONTRIBUTOR shall fork `MAINTAINER/collab2` to `CONTRIBUTOR/collab2`

  ~~~~ console
  ssh <%= config[:git_url]%> fork MAINTAINER/collab2 CONTRIBUTOR/collab2
  ~~~~
  
- The CONTRIBUTOR shall clone a local copy of `CONTRIBUTOR/collab2`
- The CONTRIBUTOR shall add a remote `upstream` with the url `<%=
  config[:git_url]%>:MAINTAINER/collab2`
- The CONTRIBUTOR shall add and commit local changes and then push to `origin`

  ~~~~ console
  git push origin master
  ~~~~
    
- The CONTRIBUTOR shall notify the MAINTAINER to pull changes from `CONTRIBUTOR/collab2`
- The MAINTAINER shall add a remote `CONTRIBUTOR` with the url `<%=
  config[:git_url]%>:CONTRIBUTOR/collab2.git`
- The MAINTAINER shall pull changes from `CONTRIBUTOR`

  ~~~~ console
  git pull CONTRIBUTOR master
  ~~~~
    
## User Contributions

Each user shall be responsible for contributing the following files to
the repo.  For extra practice, type the code into your text editor by
hand rather than copy/paste. This will train your muscle memory for
python syntax (it really does help!)

### User1

Create a file named `record_jar_reader.py` containing the following code:

<%= code_snippet('record-jar/record_jar_reader.py') %>

Be sure to set the execution bit.

### User2

Create a file named `planets.py` containing the following code:

<%= code_snippet('record-jar/planets.py') %>

Be sure to set the execution bit.
