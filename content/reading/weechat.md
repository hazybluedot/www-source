---
title: Connect to IRC with weechat
---

# Get on the IRC Channel

WeeChat is one of many
[IRC](http://www.irchelp.org/irchelp/new2irc.html)
[clients](http://www.irchelp.org/irchelp/clients/).  I recommend it
here because it is fairly simple to setup and use but of course you
are free to use any client, [irssi](http://www.irssi.org/) is another
popular console based client.  Console based clients, as opposed to
GUI based, play well with other tools such as tmux to
[set up persistent connections](https://vtluug.org/wiki/Shell_account_tutorial).

## Background

- [WeeChat Quick Start Guide](http://www.weechat.org/files/doc/devel/weechat_quickstart.en.html)
- [The IRC Prelude](http://www.irchelp.org/irchelp/new2irc.html)

## Connect to your shell account

You *could* run WeeChat locally on your own machine, but then you
will miss out on any conversation when your computer is off or
disconnected, so it's recommended to use your shell account.

~~~~ console
$ ssh username@ece2524.ece.vt.edu
~~~~

Where `username` is your CVL account name.

## Use WeeChat to join #ece2524

1. Start weechat

   ~~~~ console
   $ weechat-curses
   ~~~~

2. Follow the
   [Quick Start](http://www.weechat.org/files/doc/devel/weechat_quickstart.en.html)
   guide to setup WeeChat for the first time.

   - Our channel is on the oftc network and by a lucky happenstance
     the Quick Start guide uses oftc
     [as an example](http://www.weechat.org/files/doc/devel/weechat_quickstart.en.html#create_irc_server)
   - In IRC speak your 'nick' is the name associated with you. Names
     on any given IRC server must be unique and are assigned on a
     first-come-first serve bases, so there is a chance that your
     preferred choice is not available. This is why you give a list of
     nicks to use in [Set custom IRC server options](http://www.weechat.org/files/doc/devel/weechat_quickstart.en.html#irc_server_options).
   - Our channel name is `#ece2524`, you may also choose to join [VTLUUG's channel](https://vtluug.org/irc/): `#vtluug`

## In the channel

Once you have joined the channel you have a wealth of IRC commands
available to you. To get started, peruse an
[IRC tutorial](http://www.irchelp.org/irchelp/irctutorial.html), there
are many sprinkled around the web. Generally:

- message you type in the weechat's command window that do not start
with `/` will be treated as a message sent to the channel.
- To send a private message to another user

  ~~~~ irc
  /msg nick
  ~~~~
  
- The `@` in front of my nick (`dkm`) means that I am the channel operator.
- A `+` in front of a nick means that user has
'[voice](http://answers.yahoo.com/question/index?qid=20080416002817AAXgf1q)'. While
this status has some meaning in terms of privilege (users with 'voice'
can send messages even when the channel is muted), it is often uses to
simply to force those user's nicks to float towards the top of the
user list. Those members marked with `+` are either ECE2524 veterans,
or experienced Linux/Unix users from the VTLUUG or community who
volunteer their time to respond to questions.

## Persistent Connection

The IRC protocol does not provide a mechanism for retreiving messages
sent to a channel that you are not logged into, so once you close your
client you are essentially removed from the conversation until the
next time that you log in. Since weechat is a console based
application we can use a terminal multiplexer utility such as tmux or
screen to create a virtual terminal that we can detach and reattach
to. See the
[Shell account tutorial](https://vtluug.org/wiki/Shell_account_tutorial)
provided by the VTLUUG to get this working.

## A Note about etiquette and persistence

While many of us, myself included, will be logged into the channel
persistently, in general you shouldn't assume that just because you
see someone in the channel it means they are actively watching the
conversation. This has some implications as far as how you go about
asking questions and getting people's attention.

- If you have a general question for anyone to answer, simply ask it
- The question 'is anyone around' isn't always useful, treat the
  channel more as a message board rather than a real-time chat and you
  will generally have a more productive experience.
- Of course, if it is clear that there ARE people around, i.e. there
  is active chatting taking place, then treat it as a real-time chat
- You will notice that weechat highlights messages that contain your
  nick. WeeChat has tab-completion for nicks, so to respond to a
  particular user, start typing their nick, press <TAB> and then enter
  your message. This is generally called a 'mention'. Use this feature
  to get someone's attention or find out if a particular user is
  around by 'pinging' them. For instance, to see if I'm actually
  around, send "dkm: ping" to the channel.

## Register your nick

nicks on IRC are uniq to the network and are assigned on a
first-come-first-serv bases. Because of this, it's possible that
someone other than you may use your preferred nick once you log off,
preventing you from using it the next time you log on. To avoid this,
and ensure that only you are able to use your preferred nick you can
[register it with the NickServ service](http://www.oftc.net/Services/#register-your-account).
