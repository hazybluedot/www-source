---
title: Setting up SSH Key Authentication
provides: { background: ssh/keyauth, practice: ssh/keyauth }
---

Users who are running a local *nix system: Max OS X, dual boot or
VirtualMachine Linux, should run this command from their local
machine, i.e. before connecting to a remote shell with `ssh`.  If your
only *nix access is your shell account, then complete this from that
command prompt.

~~~~ console
$ ssh-keygen
~~~~
{: .no-explain }

Accept the default values.  For added security you may choose to use a
passphrase.

Once the command completes there should be two additional files in
your `~/.ssh` directory:

~~~~ console
$ ls ~/.ssh
id_rsa  id_rsa.pub
~~~~
{: .no-explain}

These are your private (`id_rsa`) and public (`id_rsa.pub`) keys.  The
private key should remain where it is, never copy it to a different
location or share it with anyone or anything.  It should be readable
and writable by you and only you.  The public key (`id_rsa.pub`) is
the file you will copy to remote servers to enable authentication.

## SSH config file

An ssh config file can help save typing.  Create a file named
`~/.ssh/config` and enter the following text

~~~~ text
Host ece2524git
        HostName ece2524.ece.vt.edu
        User git
        IdentityFile ~/.ssh/id_rsa # useful if you create multiple keys for different remote connections
        ForwardAgent yes           # add this line if your key is on your local machine
~~~~

With this entry in your `~/.ssh/config` you can just use `ece2524git`
in place of `git@ece2524.ece.vt.edu` in any future instructions. Note
that `ece2524git` is an arbitrary name you are giving to this local
entry, you could put anything you want after the `Host` keyword and
use that instead.
