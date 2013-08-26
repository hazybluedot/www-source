---
title: Common Git Errors
created_at: August 26
---

When trying to push:
~~~
error: src refspec master does not match any.
error: failed to push some refs to 'ece2524git@ece2524.ece.vt.edu:some-repo-name.git'
~~~

The most frequent cause of this is trying to push an empty repo, i.e. one in which no commits have been made yet. Be sure to `add` and `commit` at least one file before doing a `push`.

