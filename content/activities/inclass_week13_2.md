---
title: "Projects and Whatnot"
---

## Project Discussion

- [Project Guidelines](/project_guidelines/)

## Quiz Feedback

- Both data file metaformats (DFM) and language specific datatypes (LSD) deal with
  how data is stored

  - DFMs define data using ASCII or UTF-8 characters making them
    suitable for storing as files on disk. They are *portable* and
    *language independent* and *human readable*. To use the data
    stored in them in a program some kind of *parser* is required.

  - LSDs define data in some binary form and are *language* and
  *architecture* dependent. For instance in *C* the number of bits in
  an *int* and how they are ordered in memory is architecture
  dependent. And *int* in *Python* may have a different binary
  representation than an *int* in *C*.  The data stored as LSDs are
  *not* portable, it usually doesn't make sense to use them outside of
  the specific program that define them. Because of this datatype
  values are usually only stored in memory while the program is
  running (depending on the language and compiler, certain LSDs may be
  stored as part of the program data on disk).

## Follow Up Questions

1. Different metaformats may parsed faster than others. How much
   concern should we give to the parsing speed of a particular format
   when choosing one to use for a text-based adventure game?

2. XML would also work well for representing the data in a text-based adventure game. It also provides another layer of meaning by allowing us to define a scheme: a set of rules that dictate how data can be organized, e.g. we could specify that a room could contain one or more items, but an item can't contain one or more rooms.  YAML or JSON doesn't provide this level of detail:

   ~~~~ yaml
   SURGE 104C: 
       desc: a generic classroom
       items: [ desk, chalk, a mysterious note ] 
       north: SURGE Study Area
   ~~~~

   and 

   ~~~~ yaml
   
   SURGE 104C:
     desc: a generic classroom
     items:
     - desk
     - chalk
     - a mysterious note
     - SURGE Study Area: {desc: an open space, items: vending machine, south: SURGE 104C}
     north: SURGE Study Area
   ~~~~

   are both valid YAML but the latter example is not a well-formed
   representation of a multi-room game environment. Is this motivation
   for XML?
