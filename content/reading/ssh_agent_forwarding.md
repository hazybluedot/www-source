---
title: SSH Agent Forwarding
kind: reading
---

## *nix (including OS X) Users

### Copy your public key to the server

If you have the `ssh-copy-id` command available (most Linux
distributions, unfortunately, not available by default on Mac OS X).

~~~~ console
$ ssh-copy-id -i ~/.ssh/id_rsa.pub <cvl_username>@ece2524.ece.vt.edu
~~~~
{: .no-explain .command-syntax}

If the `ssh-copy-id` command is not available you can run the
following commands instead.  You will be prompted for your CVL account
password for each command.

~~~~ console
$ cat ~/.ssh/id_rsa.pub | ssh <cvl_username>@ece2524.ece.vt.edu 'mkdir .ssh; cat >> .ssh/authorized_keys'
$ ssh <cvl_username>@ece2524.ece.vt.edu 'chmod 700 .ssh; chmod 600 .ssh/authorized_keys'
~~~~
{: .no-explain .command-syntax }

### Add your key to your local SSH Agent

    $ ssh-add

### Connect

   If everything worked, your keys should be used for authentication the next time you ssh into your shell acount

~~~~ console
$ ssh <cvl_username>@ece2524.ece.vt.edu
~~~~
{: .no-explain .command-syntax }

   If you used a passphrase when creating your key you will be promted to enter it.

