---
title: Basics of Command Line Argument Parsing
provides:
  - background: cla_parsing
---

## The Basics of command line argument parsing

As you will find, depending on the language you are writing in there
will be one or more different library functions available to aid in
command line argument parsing. All of them will be structured in a
similar fashion and follow similar usage patterns:

1. Configure the parser with the command line options you want to
   accept. In some of the more high-level libraries you will also
   define help strings for each option at this stage.
2. Invoke the parser.
3. Process the resulting data structure to set flag variables. With
   many of the higher level parsers you can use the data structure
   returned by the previous step directly.

## The Basics of `optget`

1. Configure the parser.  The configuration is a single string
   containing each letter that is a valid program option. For example,
   if you wanted to accept `-q` and `-v` the configuration string
   would be `"qv"`. Options that take a required argument, like `-n`
   for the `head` command are followed by a single `:`. If you want to
   accept `-q` which doesn't take an extra argument and `-n` which
   requires a value be given after it, the configuration string would
   be `"qn:"`.
2. Invoke the parser.  Call `getopt` passing it `argc`, `argv` and
   your configuration string.  Each time you call it it will return
   either another option from the command line argument list, or -1 if
   there are no more options.  Typically this part is implemented by
   calling `getopt` in a while loop until -1 is returned. Assuming all
   variables have been properly declared:


        while ((opt = getopt(argc, argv, "qn:")) != -1) {
             //handle each option stored in `opt`
        }
    {: .language-c }

3. Process the resulting data.  This happens in the body of the while
   loop and is generally handled with a `case` statement:

        switch (opt) {
        case 'q':
            quiet = 1;
            break;
        case 'n':
            N = atoi(optarg);
            break;
        default: /* '?' */
            fprintf(stderr, "Usage: %s [-n N] [-q]\n", argv[0]);
            exit(EXIT_FAILURE);
        }
   {: .language-c}

   See the EXAMPLES section of the `getopt(3)` manual page for a full
   working example.  Keep the body of the cases simple, typically you
   will just set flags here and do basic data sanitization, like
   converting extra arguments (automatically stored in `optarg`, if
   the given argument takes a required value) to a final data
   type. Keep your program logic and your option parsing logic
   separate, this makes it easier to modify and maintain each!

## Activities
- [Balanced Brace Checker](/activities/balanced_cli_options/index.html)
