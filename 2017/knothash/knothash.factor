using: grouping kernel math sequences sequences.rotated vectors
;
in: 2017.knothash

: (hash) ( seq n -- seq )
    [ 0 0 256 <iota> >vector ] 2dip [ [ [
        reach overd <rotated> over head-slice reverse! drop
        [ [ + + 256 mod ] keepd 1 + ] curry dip
    ] each ] keep ] times drop 2nip ;

: hash ( seq -- seq )
    { 17 31 73 47 23 } append 64 (hash) 16 group
    [ 0 [ bitxor ] reduce ] map ;
