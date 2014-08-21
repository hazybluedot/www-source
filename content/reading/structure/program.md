---
title: Program Structure
provides: { background:  structure/toplevel }
kind: reading
---

~~~ c
<<*>>=
<<include library headers>>

<<include local headers>>

<<main>>
@
~~~

~~~ c
<<main>>=
int main(int argc, char *argv[]) {
    <<variable declarations>>

    <<command line option parsing>>

    <<main loop>>

    <<cleanup and exit>>
}
@
~~~

