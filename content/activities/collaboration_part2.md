---
title: Planetary Collaboration -- Part 2
---

To make things a little more readable, and to better match my
examples, I am going to use the user `rflowers` as `User1` and the
`MAINTAINER` `spilgrim` as `User2` and the `COLABORATOR`.  In the
following examples, replace these usernames with your own, depending
on your role.

Start by working with the repos you used for the
[Integration-manager workflow](/reading/distributed_workflow/#integration-manager-workflow),
`collab2`.  If you get done with that then repeat the exercise using a
[centralized workflow](/reading/distributed_workflow/#centralized-workflow)
ensuring that both people in the group have a chance to resolve a
merge conflict.

## Edit

`rflowers` decides the output should have a nice
header line and modifies `planets.py` accordingly:

<%= code_snippet('collaboration/part2/user1/planets.py') %>

Meanwhile, `spilgrim` decides the planet information would be better
stored as a custom class rather than a dictionary. He implements a
Planet class and changes his `planets.py` to

<%= code_snippet('collaboration/part2/user2/planets.py') %>

Notice the use of a
[list comprehension](/reading/pythonisms/#list-comprehension) (note
4). This has become one of Python's core idioms and is very useful for
expressing complex list transformations succinctly.  We'll explore
list comprehensions more next week.

1. Working in pairs, take on the roles of `rflowers` and `spilgrim`
2. In your `collab2` working directory, make changes to your own code
   (you don't need to include all the comments in `spilgrim`'s version
   of `planets.py`, just the code).
2. Add and commit your changes
   locally to `USER/collab2`
3. push your local changes to your own personal remote that you have named `origin`

## Attempt Merge

`spilgrim` is excited about his new change, he pushes his changes to his public remote and sends a pull request to `rflowers`

`rflowers` attempts to merge the pull request sent by `spilgrim`

~~~~ console
[rflowers@localhost]$ git pull spilgrim master
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From ece2524.ece.vt.edu:spilgrim/collab2
 * branch            master     -> FETCH_HEAD
 Auto-merging planets.py
 CONFLICT (content): Merge conflict in planets.py
 Automatic merge failed; fix conflicts and then commit the result.
$
~~~~

Git is unable to perform the merge automatically and alerts `rflowers`
that there is a conflict in `planets.py`. Git has modified the copy of
`planets.py` in the working directory to include details about what it
couldn't merge.

<%= code_snippet('collaboration/part2/conflict/planets.py') %>

Notice that git was able to merge the addition of the planet class
definition without any problem, it has narrowed down the conflict to
just the 4 lines in the `__main__` block.  The code between `<<<<<<< HEAD` and `=======` is what was in `rflowers`'s copy. The code between `=======` and `>>>>>>> 327027` is what was in `spilgrim`'s public repo.

`rflowers` has two choices:

1. Resolve the conflict herself

   - edits `planets.py`, removing the lines git has added and merging
     the code as they see fit.
   - adds the modified `planets.py`

     ~~~~ console
     [rflowers@localhost]$ git add planets.py
     ~~~~

   - and commits the merge

     ~~~~ console
     [rflowers@localhost]$ git commit
     ~~~~

     Notice that when git opens up the commit message it is already
     populated with some text about a merge. In most cases you will just
     accept it as is, save the file and complete the commit.

   - pushes the merged changes back to their remote

     ~~~~ console
     [rflowers@localhost]$ git push
     ~~~~

2. Tell `spilgrim` to merge his repo with `upstream` and resolve the conflict and then issue another pull request

   - `rflowers` runs

     ~~~~ console
     [rflowers@localhost]$ git reset --hard
     ~~~~

     to reset her working directory to the commit before the failed merge attempt
   - `rflowers` double checks that her changes are up to date on her own public remote

     ~~~~ console
     [rflowers@localhost]$ git push
     ~~~~

     and notifies `spilgrim` to resolve the merge himself.

   - `spilgrim` pulls changes from `upstream`

     ~~~~ console
     [spilgrim@localhost]$ git pull upstream master
     ~~~~

     and will be notified of the merge conflict in `planets.py`. He
     will edit the file to resolve the conflict and add/commit the
     merge, then push the changes to his `origin`, `spilgrim/collab2`

     ~~~~ console
     [spilgrim@localhost]$ # edit planets.py to resolve conflict
     [spilgrim@localhost]$ git add planets.py
     [spilgrim@localhost]$ git commit # accept default merge message
     [spilgrim@localhost]$ git push origin master
     ~~~~
  - `spilgrim` sends another pull-request to `rflowers`.  Assuming she
    hasn't made any additional conflicting changes to her own copy,
    she should now be able to pull in changes from `spilgrim/collab2`
    without any conflict.
   
## Fetch and Merge in two steps (optional)

A git `pull` is doing two things, it is first fetching updates from
the remote and then merging them into the local branch. We can do each
of these steps individually. Why would we want to run two commands
instead of one? More flexibility in controlling the merge process.

To try this out we will first have to undo the merge that we already
completed.

If your run `git log` you will see that the merge is the most recent
commit, the one before that is when `rflowers` added the header line.
To undo the merge run

~~~~ console
$ git reset HEAD~1 --hard
~~~~

The `HEAD~1` syntax refers to "one commit before `HEAD`". View the
`planets.py` in your working directory to confirm it is at the
pre-merged state.

1. `rflowers` fetches changes from her `spilgrim` remote

   ~~~~ console
   [rflowers@localhost]$ git fetch spilgrim master
   ~~~~

2. she can now easily see the `diff` between her own version and `spilgrim`'s

   ~~~~ console
   [rflowers@localhost]$ git diff master spilgrim/master
   ~~~~

   possibly using that information to decide whether or not to perform
   the merge herself, or ask `spilgrim` to do it.
   
2. If she decides to perform the merge herself, she runs

   ~~~~ console
   $ git merge spilgrim/master
   ~~~~

## Review the log

~~~~ console
$ git log --graph --pretty=format:"%h -- %an, %ar: %s"
*   ac99365 -- Ramona Flowers, 3 minutes ago: Merge remote-tracking branch 'spilgrim/master'
|\
| * 7b16d92 -- Scott Pilgrim, 12 minutes ago: implement Planet class
* | 09d707d -- Ramona Flowers, 11 minutes ago: add header to output
|/
* 436c9b3 -- Scott Pilgrim, 3 hours ago: add planets
* c6df563 -- Ramona Flowers, 3 hours ago: add record_jar_reader
~~~~

Read [Viewing the Commit History](http://git-scm.com/book/en/git-basics-viewing-the-commit-history) for more ways to view the log.

## Common Problems

- Uncommitted changes in working directory before attempting a merge
