USING: grouping kernel math math.parser sequences
sequences.extras sequences.rotated vectors ;
IN: 2017.10

! Knot Hash

: (hash) ( seq n -- seq )
    [ 0 0 256 <iota> >vector ] 2dip [ [ [
        reach overd <rotated> over head-slice reverse! drop
        [ [ + + 256 mod ] keepd 1 + ] curry dip
    ] each ] keep ] times drop 2nip ;

: part-1 ( seq -- n ) 1 (hash) first2 * ;

: hash ( seq -- seq )
    { 17 31 73 47 23 } append 64 (hash) 16 group
    [ 0 [ bitxor ] reduce ] map ;

: part-2 ( seq -- str )
    hash [ >hex 2 CHAR: 0 pad-head ] map-concat ;
