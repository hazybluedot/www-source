---
title: Discussion
requires: { background: [ complexity ] }
---

1. If we to change the definition and subsequent implementation of our `balanced` algorithm from

   ~~~ cpp
   balanced(std::istream& is)
   ~~~

   to

   ~~~ cpp
   balanced(std::string file_name)
   ~~~

   we would be adding complexity and breaking orthogonality because
   the `balanced` function would be responsible for handling file I/O.
   
   1. Would this be considered accidental or optional complexity?
   2. Where would it fall on the "sources and kinds of complexity" graph?

2. Assume we changed the specification of he program to include a line

   > If a supplied file name can not be opened or read then prompt the user and ask for a different file name

   what form of complexity would we be adding?

3. If we added to the specification a new program option

   ~~~
   -o <filename>   Write output to <filename>
   ~~~

   1. What form of complexity would be added?
   2. What are the tradeoffs?
   3. When might the tradeoffs make sense to add this complexity?

      Hint: What happens if you try to redirect the output of a program to one of its input files?

      ~~~ console
	  $ grep '.*' file.txt > file.txt
      ~~~

      To handle this use case, if it makes sense for our program (does
      it make sense for `balanced`?), the standard approach is to add
      a `-i` flag for "edit in place", for example, see `sed(3)`
