---
title: Program Structure
kind: reading
goals:
 - "good design at one level impacts on good design at others."
 - "understanding different types of structures can aid in quick prototype phase"
 - "the 'Unix' way as it relates to word frequency count"
 - "recognizing what the potentially reusable parts are"
 - "readable, understandable code does *not* necessarily me a lot of comments"
---


> We understand a complicated system by understanding its simple
> parts, and by understanding the simple relations between those parts
> and their immediate neighbors. -- Donald Knuth,
> [literate_programming]

[literate_programming]: http://literateprogramming.com/knuthweb.pdf

## The Word Count Problem

[McIlroy noted][mcilroy_review] that his pipeline solution took a different approach
than Knuth's example.

> At a sufficiently abstract level both may be described in the same
> terms: partition the words of a document into equivalence classes by
> spelling and extract certain information about the classes.

[mcilroy_review]: http://doi.acm.org/10.1145/5948.315654

He claims that the "intuitive" solutions for people experienced with
Unix may be different as a result of the Unix culture.

> Everybody has an instinctive idea how to solve this problem, but the
> instinct is very much a product of culture: in a small poll of
> programming luminaries, all (and only) the people with Unix
> experience suggested sorting as a quick-and-easy technique.

The solution was made possible not because someone sat down at some
point to solve the Word Count Problem, but because the solution can be
realized by combining small pieces, each of which evolved out of
necessity for something else.

> The utilities employed in this trivial solution are Unix
> staples. They grew up over the years as people noticed useful steps
> that tended to recur in real problems. Every one was written first
> for a particular need, but untangled from the specific application.

## Not an Accident

The design of Unix encourages small programs that work well together.

    $ ./tolower

  ![fork_exec](/assets/images/fork_exec.svg)

    $ ./tolower <jump.txt

  ![fork_redir_exec](/assets/images/fork_redir_exec.svg)


## Program Structure

- [stdio pattern](/reading/patterns/stdio/)
