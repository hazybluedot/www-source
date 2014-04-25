---
title: File Permissions
provides: { background: filesystem/permissions }
---

Read [Chapter 9](/assets/TLCL-13.07.pdf#page=112) of [TLCL](/assets/TLCL-13.07.pdf).  

## Self Study

Review the process fork/exec diagram:

    $ ./tolower

[fork/exec flow](/assets/images/fork_exec.svg)

When you type the name of a command at the prompt and press `<Enter>`:

1. at which point in the diagram is your permission to execute the
   program checked?
2. what is responsible for the the check, the shell or the kernel?

and

    $ ./tolower <jump.txt

[fork/redirect/exec flow](/assets/images/fork_redir_exec.svg)

When you run a command with its input or output redirected:

1. at which point in the diagram is your permission to read or write
   to the redirected file (in this case, permission to read
   ‘jump.txt’) performed?
2. what is responsible for performing the permission check, the shell
   or the kernel?
        

