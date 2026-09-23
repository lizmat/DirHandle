use P5opendir:ver<0.0.10+>:auth<zef:lizmat>;

class DirHandle {
    has $.dirhandle;

    method new($path) {  # UNCOVERABLE
        opendir(my $dirhandle, $path) ?? self.bless(:$dirhandle) !! Nil
    }

    multi method open(DirHandle:U: $path) { DirHandle.new($path) }
    multi method open(DirHandle:D: $path) {  # UNCOVERABLE
        closedir($!dirhandle);
        opendir($!dirhandle, $path) ?? self !! Nil
    }

    method close(\SELF:) {  # UNCOVERABLE
        my $result := closedir($!dirhandle);
        SELF = Nil;
        $result
    }

    multi method read(Mu:U) {  # UNCOVERABLE
        CALLER::LEXICAL::<$_> = readdir(Scalar, $!dirhandle)
    }
    multi method read() { readdir(Scalar, $!dirhandle) }

    method rewind()         { rewinddir($!dirhandle)       }
    method tell()           { telldir($!dirhandle)         }
    method seek(Int() $pos) { seekdir($!dirhandle,$pos)    }

    method Str() { $!dirhandle.Str }
}

# vim: expandtab shiftwidth=4
