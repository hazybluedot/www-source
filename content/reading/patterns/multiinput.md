---
title: Multi-input, single output filter
requires: { background: structure/toplevel }
kind: reading
---

~~~ c
<<main loop>>=
   while(<<there are file names left>>) {
       <<process file name>>
   }
@
~~~

~~~ c
<<process file name>>=
<<open file>>
<<error or process stream>>
<<close file>>
@
~~~

~~~ c
<<open file>>=
fp = fopen(<<file name>>, "r");
@
~~~

~~~ c
<<error or process stream>>=
if ( fp == NULL ) {
    <<handle file error>>
} else {
    <<process stream>>
    <<close file>>
}
@
~~~

