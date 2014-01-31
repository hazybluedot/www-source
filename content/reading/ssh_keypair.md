---
title: Setting up SSH Key Authentication
provides: { background: ssh/keyauth, practice: ssh/keyauth }
---

Users who are running a local *nix system: Max OS X, dual boot or
VirtualMachine Linux, should run this command from their local
machine, i.e. before connecting to a remote shell with `ssh`.

~~~~ console
$ ssh-keygen
~~~~

Accept the default values.  For added security you may choose to use a
passphrase.

Once the command completes there should be two additional files in your `~/.ssh` directory:

~~~~ console
$ ls ~/.ssh
id_rsa  id_rsa.pub
~~~~

These are your private (`id_rsa`) and public (`id_rsa.pub`) keys.  The
private key should remain where it is, never copy it to a different
location or share it with anyone or anything.  It should be readable
and writable by you and only you.  The public key (`id_rsa.pub`) is
the file you will copy to remote servers to enable authentication.
