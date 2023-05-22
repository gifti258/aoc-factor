USING: aoc.input aoc.matrices arrays combinators.extras kernel
math math.matrices math.parser sequences
sequences.generalizations ;
IN: 2021.20

! Trench Map
! Number of lit pixels in enhanced image

: parse ( paragraph1 paragraph2 -- seq m )
    [ first #-vector ] [ [ #-vector ] map ] bi* ;

: enhance-twice*n ( seq m n -- n )
    [
        [
            [ 0 [ prefix ] [ suffix ] bi ] map
            dup length 2 + 0 <array> [ prefix ] [ suffix ] bi
        ] thrice [
            dup length
            dup -1 0 1 [ <simple-eye> ] tri-curry@ 2tri
            [ [ swap mdot ] tri-curry@ tri ] 3keep
            spin [ [ mdot ] tri-curry@ tri ] 3curry tri@
            [ [ 9 narray [ >digit ] map bin> ] 9 nmap ] 9 nmap
            dupd [ [ swap nth ] with map ] with map
        ] twice rest but-last [ rest but-last ] map
    ] times matrix-sum nip ;

: part-1 ( seq m -- n ) 1 enhance-twice*n ;

: part-2 ( seq m -- n ) 25 enhance-twice*n ;
