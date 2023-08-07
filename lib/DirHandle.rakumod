use v6.d;

use P5opendir:ver<0.0.8>:auth<zef:lizmat>;

class DirHandle {
    has $.dirhandle;

    method new($path) {
        opendir(my $dirhandle, $path) ?? self.bless(:$dirhandle) !! Nil
    }

    multi method open(DirHandle:U: $path) { DirHandle.new($path) }
    multi method open(DirHandle:D: $path) {
        closedir($!dirhandle);
        opendir($!dirhandle, $path) ?? self !! Nil
    }

    method close(\SELF:) {
        my $result := closedir($!dirhandle);
        SELF = Nil;
        $result
    }

    multi method read(Mu:U) {
        CALLER::LEXICAL::<$_> = readdir(Scalar, $!dirhandle)
    }
    multi method read() { readdir(Scalar, $!dirhandle) }

    method rewind()         { rewinddir($!dirhandle)       }
    method tell()           { telldir($!dirhandle)         }
    method seek(Int() $pos) { seekdir($!dirhandle,$pos)    }

    method Str() { $!dirhandle.Str }
}

=begin pod

=head1 NAME

Raku port of Perl's DirHandle module

=head1 SYNOPSIS

    use DirHandle;
    with Dirhandle.new(".") -> $d {
        while $d.read -> $entry { something($entry) }
        $d->rewind;
        while $d.read(Mu) { something_else($_) }
        $d.close;
    }

=head1 DESCRIPTION

This module tries to mimic the behaviour of Perl's C<DirHandle> module
as closely as possible in the Raku Programming Language.

The DirHandle object provides an alternative interface to the C<opendir>,
C<closedir>, C<readdir>, C<telldir>, C<seekdir> and C<rewinddir> functions.

The only objective benefit to using DirHandle is that it avoids namespace
pollution.

=head1 PORTING CAVEATS

=head2 Handling void context

Since Raku does not have a concept like void context, one needs to specify
C<Mu> as the only positional parameter with C<read> to mimic the behaviour
of C<DirHandle.read> of Perl in void context.

Please note that due to optimizations in Raku from version C<6.d> onwards,
it is no longer possible to (always) assign to C<$_> in the caller's
scope.  So this either locks your code into C<6.c>, or you will need to
change your code to do explicit assignment with the C<read> method.

=head2 Extra methods

The Perl version of C<DirHandle> for some mysterious reason does not
contain methods for performing a C<telldir> or a C<seekdir>.  The Raku
version B<does> contain equivalent methods C<tell> and C<seek>.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

Source can be located at: https://github.com/lizmat/DirHandle . Comments
and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018, 2019, 2020, 2021, 2023 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
