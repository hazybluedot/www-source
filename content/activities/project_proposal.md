---
title: Project Proposal
kind: activity
tests:
 - type: bonair
   feature: features/project
repos:
 - user: USER/project
---

As a group, create a text file named `README` or `README.md` containing the following information

~~~~ text
Summary of project, just a few sentences. This will be displayed on
the project index page. If you format your file with [markdown](http://daringfireball.net/projects/markdown/),
then name it `README.md`

<!-- more -->

Description of the project. Be sure to explain how you plan to use
elements of Unix design philosophy to implement the project.
~~~~

and a file named `README.yaml` with

~~~~ yaml
---
title: "Project Title"
contributors: astudent, rflowers, spilgrim
url: https://github.com/rflowers/super_cool_project
---
~~~~

You may leave the url empty if you haven't set up a
[github](https://github.com/) page yet.  The contributors should be a
comma separated list of user names (not emails, not real names, not a
combination of one or the other, just one username per person).

Each member of the group should add a copy of the `README` file to
their own repo `USER/project` and push to the server.
