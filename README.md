[![Actions Status](https://github.com/lizmat/DirHandle/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/DirHandle/actions) [![Actions Status](https://github.com/lizmat/DirHandle/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/DirHandle/actions) [![Actions Status](https://github.com/lizmat/DirHandle/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/DirHandle/actions)

NAME
====

Raku port of Perl's DirHandle module

SYNOPSIS
========

```raku
use DirHandle;
with Dirhandle.new(".") -> $d {
    while $d.read -> $entry { something($entry) }
    $d->rewind;
    while $d.read(Mu) { something_else($_) }
    $d.close;
}
```

DESCRIPTION
===========

This module tries to mimic the behaviour of Perl's `DirHandle` module as closely as possible in the Raku Programming Language.

The DirHandle object provides an alternative interface to the `opendir`, `closedir`, `readdir`, `telldir`, `seekdir` and `rewinddir` functions.

The only objective benefit to using DirHandle is that it avoids namespace pollution.

PORTING CAVEATS
===============

Handling void context
---------------------

Since Raku does not have a concept like void context, one needs to specify `Mu` as the only positional parameter with `read` to mimic the behaviour of `DirHandle.read` of Perl in void context.

Please note that due to optimizations in Raku from version `6.d` onwards, it is no longer possible to (always) assign to `$_` in the caller's scope. So this either locks your code into `6.c`, or you will need to change your code to do explicit assignment with the `read` method.

Extra methods
-------------

The Perl version of `DirHandle` for some mysterious reason does not contain methods for performing a `telldir` or a `seekdir`. The Raku version **does** contain equivalent methods `tell` and `seek`.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

Source can be located at: https://github.com/lizmat/DirHandle . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2018, 2019, 2020, 2021, 2023, 2024 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

