---
title: "Editing Files in a Unix Envrionment"
provides: { background: tools/editor_intro }
kind: reading
---

## Working with Remote Files

The easiest way to get started is to use the editing tools you are
already familiar with on your native system. If you are feeling
overwhelmed with the new tools we have been learning then I recommend
this approach at first so that you can concentrate more on writing
good programs.

1. Follow the instructions to [mount your ECE filebox][ECE_Filebox].
2. You should see your remote files and directories in your local
   system's file manager. Create and edit files as you would if they
   were local.
   - Be sure to use a text editor such as notepad on Windows or
   TextEdit on OS X. You may also choose to use an IDE such as
   VisualStudio or XCode, but take care to just use the editing
   features: don't create a project and don't compile your code from
   within the IDE (at least at first).
3. Once you save changes you should see the same files with the same
   contents when you are connected to your shell account using the
   Unix filesystem commands (`cd`, `ls`, `cat`, etc.)

[ECE_Filebox]: https://computing.ece.vt.edu/wiki/CVL_Filebox

## Working with Files on the Shell

There are two very popular text editors for Unix based systems: `vim`
and `emacs`.  Both are insalled on the `ece2524` server and you can
start either by typing their respective name and pressing 'Enter'. The
`nano` text editor is also installed, which is generally considered
simpler than `vim` or `emacs`, but if you're going to take the time to
learn a new interface anyway pick one of the big players will get you
futher in less time.

### vim

The easiest way to get started learning `vim` is to run the tutor program

    $ vimtutor

and follow along. For now, the main things you need to know are:

   - `vim` starts in COMMAND mode.
   - From COMMAND mode you can opena file by typing `:o ` followed by the file name and then pressing Enter.
   - From COMMAND mode you can enter INSERT mode by pressing 'i'.  You
     can use this mode to enter and edit text.
   - From INSERT mode you can enter COMMAND mode by pressing Escape
   - From COMMAND mode you can save by typing `:w` and Enter
   - From COMMAND mode you can save an quit by typing `:wq` and
     pressing Enter

### emacs

Rather than having separate operating modes Emacs allows you to access
various editing commands and features using modifier keys. The key
combinations as

  - `C-x` meaning press `Ctrl` and `x` at the same time and
  - `M-x` meaning press the "Meta" key and `x` at the same time (the
   "Meta" key is usually `Alt` on today's keyboards).

When a letter comes after a command sequence without a `-` it means press it separately:

  - `C-x f` means "Press `Ctrl` and `x` at the same time, release both
    keys and press `f`".  This will open a prompt in the mini-buffer
    at the bottom of the screen to enter a file name to open or
    create. Press Enter after type the name of the file to open and
    start editing it.
  - `C-x s` will save the file displayed in the current buffer (whatever you're looking at)
  - `C-x c` will quit `emacs`

There are many online guides for learning more emacs, try starting
wtih [Beginner's Guide to Emacs][beginners_emacs].

[beginners_emacs]: http://www.masteringemacs.org/articles/2010/10/04/beginners-guide-to-emacs/

One more important tip: If you find yourself "stuck" insome command
which is expecting you to type something in the mini-buffer at the
bottom of the screen, but you aren't sure what to do and don't know
how you got into that command in the first place just press
`C-g`. `C-g` will always cancel the current command. Sometimes you may
need to press it more than once to get back to a regular editing
environment.
