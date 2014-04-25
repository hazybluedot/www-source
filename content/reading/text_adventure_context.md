---
title: "Text Based Adventure Game: Philosophy and Concepts"
kind: reading
---

Text based adventure games or interactive-fiction could range in
complexity from a simple multiple-choice system that allows a player
to pick which part of a story to visit next to a complex RPG-style
game with a persistent, dynamic game world in which the player can
interact with items, NPCs (non-player charaters) and possibly other
players.

In the game world there may be multiple *rooms*, each with a *name* and
*description*.  Rooms may contain doors or *paths* to other rooms in
the game world. Rooms may contain zero or more *items*, some of which can
be picked up by the *player*, others which can not.

In a more complex game the *player* may have an *inventory* of items
that can be collected from the game world. The *player* may also have
*stats* (e.g. vitality, strength, charisma) that are updated after
certain events, such as winning in combat or solving a puzzle. In
turn, the value of *stats* could affect the *player*'s likelihood of
succeeding in future combat scenarios, finding items, opening locked
doors, etc.

## Game Engine

A game engine that can drive such a game will have to handle a few tasks:

1. Read a representation of the game world from a file or files stored
   on disk.  The files must be stored and formatted in a way that the
   game engine can understand.

2. Maintain in-memory data structures representing the state of the
   game world and player.

3. Read commands from the player, some examples of player commands might be

   ~~~~
   > walk north
   > look around
   > pickup candlestick
   > fight monster
   ~~~~

   commands will have to be parsed, checked for correct syntax and
   translated into in-memory structures.

4. Update the in-memory structures associated with the game world
   based on in-memory structure(s) parsed from player commands.

5. If a "save game" feature is desired, the engine will need the
   ability to translate the in-memory structure representing the state
   of the game into a Data File Metaformat that can be stored as a
   file on disk.


## Game Interface

The user interface of a text-based adventure game should be able to

1. Display information about the current state of the game environment
to the player (e.g. description of current room, list of available
items, etc).  This means it will need to be able to interact with the
game engine which maintains the data structures containing this
information.

2. Prompt the user for commands, send command strings to the game
   engine and display any errors that prevented the engine from
   understanding a command.
