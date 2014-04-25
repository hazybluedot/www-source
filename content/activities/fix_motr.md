---
title: "Check that motr is submitted"
kind: activity
---

There were some problems with the way the tests for the motr
assignment were administered causing some incorrect results, both on
the console when you pushed your code, and when scores matriculated to
gradebook on Scholar.  Those issues have been resolved for now, so
please double check the results of your motr assignment by running

~~~~ console
$ ssh <%= config[:git_url]%> show_results <cvl_username>/motr
~~~~
{:.command-syntax .no-explain}

Where `cvl_username` is the username you use to log into your shell
acount.  If the results are anything other than 3/3 review the errors
as well as [the write-up](/activities/motr/) and make any corrections
needed and then re-push.
