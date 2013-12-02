---
title: Collaboration with git
kind: activity
---

## Background

- [Distributed Workflows](/reading/distributed_workflow/)
- [Record Jar Parser](/reading/record_jar/)

## Activity

Working in pairs, practice using both a
[centralized workflow](/reading/distributed_workflow/#centralized-workflow)
and an
[integration-manager workflow](/reading/distributed_workflow/#integration-manager-workflow)

- Centralized Workflow: Use `USER/collab1`

  Pick one person to do the inital push to `USER/collab1`. That person should then add write access
  for the additional group member(s). There should be only one `USER/collab1` on the server.
  
- Integration-manager Workflow: Use `USER/collab2`

  - Decide who will be the MAINTAINER and who will be a COLLABORATOR.
  - The MAINTAINER shall initialize a local repository first
  - The MAINTAINER shall add a remote name `origin` with the url
    `<%= config[:git_url]%>:MAINTAINER/collab2`
  - The MAINTAINER shall push to `origin`
  - The CONTRIBUTOR shall fork `MAINTAINER/collab2` to `CONTRIBUTOR/collab2`
  - The CONTRIBUTOR shall clone a local copy of `CONTRIBUTOR/collab2`
  - The CONTRIBUTOR shall add a remote `upstream` with the url
    `<%= config[:git_url]%>:MAINTAINER/collab2`
  - The CONTRIBUTOR shall add and commit loal changes and then push to `origin`
  - The CONTRIBUTOR shall notify the MAINTAINER to pull changes from `CONTRIBUTOR/collab2`
  - The MAINTAINER shall add a remote `CONTRIBUTOR` with the url
    `<%= config[:git_url]%>:CONTRIBUTOR/collab2`
  - The MAINTAINER shall pull changes from `CONTRIBUTOR`

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
