## Timeline

- Now: form groups, brainstorm ideas
- By May 7: a working prototype is published
- May 7 - 11: Peer review
- May 12 - 13: Respond to feedback, address issues

## Requirements
There are a few strict requirements for the final project:

1. Must be collaborative involving the work of at least 2 people
2. Must be published on [github](https://github.com/) or another
   publically visible code repository
3. Be able to justify how your project follows Unix design
   philosophy and how it makes use of the concepts/tools we have
   talked about in class.
4. To receive credit, your author information *must* be present in the
   git log of the published repository.


## Guidelines
There are a few guidelines to be aware of

1. Always keep in mind how you can keep the program logic separate
   from the program interface, whether the interface is textual or
   graphical
2. Leverage the
   [Rule of Representation](http://catb.org/~esr/writings/taoup/html/ch01s06.html#id2878263)
   where appropriate to keep your program simple while providing a
   rich experience for the user (especially relevant for games!).  Any
   piece of data that makes sense for a user to change should be read
   from a configuration file or command line argument, not hard coded
   in the source.
3. If you choose to extend a previous project, or another open source
   project, schedule a meeting with me so we can discuss details. I
   encourage this, but it is important to be extremely clear with
   regards to what you are contributing so as to adhere to the
   Virginia Tech (and your own personal) Honor Code.
4. If you plan to write a graphical application using Qt or another
   toolkit, be sure to make an appointment with me to discuss details.
   This is something we haven't covered in class so it will take some
   extra thinking to do well.  Most of the GUI development
   environments do nothing to encourage good separation between
   interface and logic, since that is something I will be looking for
   it is important to have a clear idea of how to accomplish that for
   your particular project before starting.

## Suggestions

### General Suggestions

1. Start simple, and try to keep it simple. Remember, one of Unix's
   guiding principles is simplicity. One of the most common problems I
   have seen over the years is starting with a complex idea and
   getting overwhelmed with the details. You will only have a few
   weeks to organize, design and implement a project before the end of
   the semester.
2. If you have an idea for a larger project try to break it into a
   smaller well-defined slice that you can use for the class project.
   You can always extend your idea after the semester is over, but it
   is infinitely better to have something simple that works well by
   the end of the semester than something complex that doesn't work.


### Suggestions for Games

Text based games are fun and generally easier to get working well than
there graphical counterpart. This is especially true if you have a
creative or unique story that you want to present in the game (for
example:
[Zombie Adventure](https://github.com/bgeu/textbasedzombie.git)). Consider
a text-based game first. With good separation between game logic and
interface it should be fairly straight forward to build a graphical
interface for your game engine in the future if you do want to transition
it to a graphical environment.

### Suggestions for Utilities:

Use the `wordfreq` project as a guide and other Unix utilities we have
used such as `grep` and `tr`. Think in terms of a
[Strong Single Center](http://catb.org/~esr/writings/taoup/html/ch04s02.html#id2895445).  Make sure you can clearly define what your
algorithm is and separate that code from the interface
(reading/writing from file streams, printing output and error
messages). If the problem you are trying to solve seems to require two
or more well defined algorithms then write two or more utilities, one
for each algorithm, and use them together in a pipeline or shell
script.

# Resources
- [Projects of Semesters Past](/projects/index.html)
- [Chapter 11. Interfaces](http://catb.org/~esr/writings/taoup/html/ch11s01.html) from TAUP
- [Top-Down vs Bottom-Up](http://catb.org/~esr/writings/taoup/html/ch04s03.html#id2899552) design from TAUP
- Really the entire section on
  [Design](http://catb.org/~esr/writings/taoup/html/design.html) from
  TAUP if you have the time. Perhaps skim the headings first and pick
  one or two sections to read at more depth. It's fascinating and
  covers much more than you can likely incorporate into a final
  project done in the next few weeks, but contains a lot of valuable
  information that will aid in all future designs. While the focus is
  on software design, approach it with an open mind towards
  engineering design in general as nearly all of the ideas can be
  applied to hardware/social systems as well.
