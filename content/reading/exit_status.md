---
title: Exit Status
reference: TLCL
section: [ 27 ]
provides:
  - background: [ ipc/exit_status ]
  - component_of: [ shell_script ]
---

The *exit status* is an integer value set by a process indicating
something about its success. It's value is set by the `return` value in the `main` function, or using the `exit(3)` library call.

# Simplest Example

~~~ c
   #include <stdio.h>
   
   int main() {
       printf("Hello World");
       return 0;  // 0 means success
   }
~~~

By convention, an exit status of `0` indicates success: the program
was able to complete all tasks expected of it. A non-zero exit status
indicates the opposite.

# Using `sysexits.h`

The values used for a non-zero exit status are
generally up to the programmer, and while there is no official standard
many systems include a `sysexits.h` header file with some common error
conditions mapped to integer values:

!{snippet /usr/include/sysexits.h:/#define EX_OK/,/#define EX__MAX/}

~~~ c
#include <stdio.h>    // fopen, fclose
#include <sysexits.h> // EX_NOINPUT, EX_OK
#include <err.h>      // err

int main() {
    FILE* fp;

    fp = fopen("somefile.txt");
    if (fp == NULL) {
        err(EX_NOINPUT, "somefile.txt"); // read man page for err(3)
    } else {
        // do something with fp
        fclose(fp);
    }
    return EX_OK;
}
~~~

# Real Live Usage Example

As you may know, I am using the `gitolite` utility to manage the
multi-user git repository hosted on `ece2524.ece.vt.edu`.  By itself,
`git` doesn't worry about access control. Any user who has permission
to modify the filesystem can modify a `git` managed project stored on
that file system.  When you connect to `<%= config['git_url']%>` you
are connecting as the `<%= config['gl_user']%>` user which has
read/write access to all files in its home directory, including *all*
repositories hosted there.  So how does `gitolite` control access to
individual repositories?

~~~~ console
$ gitolite access $repo $gl_user 'R' 
~~~~

will print the access rights for the repository given. In addition,
the exit status is set depending on access, '0' if the queried user
has access of the mode requested for hte given repo, non-zero
otherwise.  Using the `-q` option will suppress normal output making
the command suitable for shell scripting

~~~ bash
if gitolite access -q $repo $gl_user 'W'; then
    show_results $reop
fi
~~~
