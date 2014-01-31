---
title: Set up a Shell Access
kind: activity
requires: { background: shell/intro }
provides: { practice: shell/access }
---

## Create an account

Refer to the
[Getting Started](https://computing.ece.vt.edu/wiki/Getting_Started)
documentation for the CVL. You want to "Create or change your ECE
Account".

## Get connected

Follow the instructions
[How to gain Remote Access to the CVL over the Internet](https://computing.ece.vt.edu/wiki/How_to_gain_Remote_Access_to_the_CVL_over_the_Internet)
for your particular operating system.

The following sections contain supplemental information and are not a
substitute for the content on the CVL wiki.

### Windows

For this class we will not need to run graphical applications over the
remote connection, so strictly speaking you will only need to install
PuTTY, not Xming. However, due to unfortunate content organization, the
final instructions to connect to the server with PuTTY are listed at
the end of the
[Xming instructions](https://computing.ece.vt.edu/wiki/Xming).

Feel free to install and use Xming too if you would like to experiment
with running graphical applications remotely.

### Mac OS X

Mac OS X is a Unix based system

### Unix Based Systems

If your CVL username is different than the local login name you used
on the computer you are connecting from you will need to include your
CVL user name in the ssh command when connecting.

    $ ssh <cvl_username>@cvl.ece.vt.edu

where you replace the string `<cvl_username>` with your actual CVL username.

### `cvl.ece` vs. `ece2524.ece`

You may notice you can connect to either of two host names:

- cvl.ece.vt.edu
- ece2524.ece.vt.edu

The machine accessible by the host name `ece2524.ece.vt.edu` is a
virtual machine configured for this class but it shares the same
authentication and home directory system that the rest of the CVL
uses, so regardless of which you log into you should have access to
any files you have stored.

The ece2524 server has these additional packages installed that are not available on the regular CVL machines:

- weechat
- git
- tmux
- clang
- gcc 4.4.7 (the CVL version is 3.4.6)

And I can install additional utilities and development libraries as we
see fit.

We will be using most of these utilities regularly in class, so you
will generally be connecting to `ece2524.ece.vt.edu`
