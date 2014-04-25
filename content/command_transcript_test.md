---
title: A Test of the Command Transcript Helper
---

A code block with two commands

~~~~ console
$ date
$ ls
~~~~

A code block with interactive commands

~~~~ console
$ ls
$ cat > afile.txt <<EOF
:the quick brown fox jumped over the lazy dog
:what does the fox say?
:EOF
$ ls
$ cat afile.txt
~~~~

A code block with a user/host specified

~~~~ console
rflowers@srdemo: $ pwd
~~~~

A code block with a user/host specified and subsequent commands

~~~~ console
spilgrim@srdemo $ pwd
$ cd wordfreq
$ pwd
~~~~

A code block with a user/host and cwd specified

~~~~ shell_session
spilgrim@srdemo:wordfreq $ pwd
~~~~

