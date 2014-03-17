---
title: Working with git remotes
kind: activity
---

## Setup
First, [create an SSH key pair](/reading/ssh_keypair/)

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

Aim to at least get this working by start of class on Wednesday.  If
you get permission errors when trying to copy your key file:

1. double check that you have replaced *both* occurances of
_cvl_username_ with your own username.
2. Usernames are case sensitive, if you have capital letters in your
   ECE username be sure to use the same case in the above command.
3. Related to the previous point, if you do have capital letters in
   your username, even if it otherwise matchies your VT PID, this is a
   case of your ECE account name and VT PID being different, so send
   me an email alterting me so that I can update my local roster file.


get through at least here by start-of-class Wednesday, February 26
{: .notice }

## Set up a remote for motr

~~~~ console
$ cd ~/ece2524/motr
$ git remote add origin git@ece2524.ece.vt.edu:<cvl_username>/motr.git
$ git remote -v
~~~~
{: .command-syntax .no-explain }

This is about as far as we got on Monday, and I know it was quite
rushed.  We'll review and pick up here on Wednesday, but feel free to
try the next few commands before then if you have time.

## Push your repo to the server

~~~~ console
$ git push -u origin master
~~~~
{: .no-explain }

## Give someone else read access

~~~~ console
$ ssh git@ece2524.ece.vt.edu perms
Usage:  ssh git@host perms -l <repo>
        ssh git@host perms <repo> - <rolename> <username>
        ssh git@host perms <repo> + <rolename> <username>
...
~~~~
{: .no-explain }

Get a neighbor's username, then give them read access to your `motr` repo

~~~~ console
$ ssh git@ece2524.ece.vt.edu perms <your_cvl_username>/motr + READERS <other_username>
~~~~
{: .no-explain .command-syntax }

## The Big Picture

<iframe src="/assets/images/git_flow.svg">
    This was supposed to be an SVG document
        in an &lt;object&gt; element.
</iframe>
[Git Workflow](/assets/images/git_flow.svg)
