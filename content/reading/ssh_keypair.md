---
title: Set up SSH Key Authentication
provides: { background: ssh/keyauth, practice: ssh/keyauth }
---

## Windows+PuTTy Users

Connect to your ECE2524 shell account with PuTTy and run these
commands from the prompt.

## *nix (including OS X) Users

Run these commands from your local shell prompt.

## Create a key pair

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

## create a SSH config file

An ssh config file can help save typing.  Create a file named
`~/.ssh/config` and enter the following text

~~~~ text
Host ece2524git
        HostName ece2524.ece.vt.edu
        User git
        IdentityFile ~/.ssh/id_rsa # useful if you create multiple keys for different remote connections
        ForwardAgent yes           # add this line if your key is on your local machine
~~~~

SSH is picky (for good reason) about file permissions and will refuse to form a connection if certain files in `~/.ssh/` are readable or writeable by anyone but you.  In particular, the default `umask` on many systems is set so that when you create `~/.ssh/config` it will have permissions `664` (`-rw-rw-r--`).  Potentially letting other users (those in the same group) write to this file is a security risk, so you need to set the permissions to either `644` or `600` before ssh will work:

    $ chmod 600 ~/.ssh/config

With this entry in your `~/.ssh/config` you can just use `ece2524git`
in place of `git@ece2524.ece.vt.edu` in any future instructions. Note
that `ece2524git` is an arbitrary name you are giving to this local
entry, you could put anything you want after the `Host` keyword and
use that instead.

## Install the key

~~~~ console
$ scp ~/.ssh/id_rsa.pub <cvl_username>@ece2524.ece.vt.edu:/keys/<cvl_username>.pub
~~~~
{: .command-syntax .no-explain}

Replace _cvl_username_ in both places with the same username you use to connect to your shell account.

## Test Authentication


~~~~ console
$ ssh git@ece2524.ece.vt.edu info
~~~~
{: .no-explain }

1. double check that you have replaced *both* occurances of
_cvl_username_ with your own username.
2. Usernames are case sensitive, if you have capital letters in your
   ECE username be sure to use the same case in the above command.
3. Related to the previous point, if you do have capital letters in
   your username, even if it otherwise matchies your VT PID, this is a
   case of your ECE account name and VT PID being different, so send
   me an email alterting me so that I can update my local roster file.


## For *nix users

If you are on a Unix-like system, finally you will need to copy your
key to the server and load your local key with your ssh agent:
[Agent Forwarding](/reading/ssh_agent_forwarding)

