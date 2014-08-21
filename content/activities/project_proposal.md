---
title: Project Description
kind: activity
---

## Background

[Project Guidelines](/project_guidelines)

## Project Description

In your project repo, as a group, create a text file named `README` or
`README.md` (but not both!) containing the following information

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
title: 'Project Title'
contributors: [ astudent, rflowers, spilgrim ]
url: 'https://github.com/rflowers/super_cool_project'
~~~~

You may leave the url empty if you haven't set up a
[github](https://github.com/) page yet but be sure to update and
resubmit when you have a URL.  The contributors should be a list of
user names (not emails, not real names, not a combination of one or
the other, just one username per person).

## Submission

You may put this `README` file in your main project repo (in most
cases this will probably be most convenient), or a separate repo just
for this purpose. Add a remote, you might use the name `origin` if you
haven't already created a remote for your project elsewhere. Push to
th remote.

~~~~ console
$ git remote add origin <%= config[:git_url]%>:<cvl_username>/project/<project_id>
$ git push -u origin master
~~~~
{:.command-syntax .no-explain}

Replace `<project_id>` with a suitable identifier for your project:

- must start with a letter
- must contain only letters, numbers, underscore (`_`) and hyphen (`-`)
