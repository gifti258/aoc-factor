using: 2017.knothash math math.parser sequences sequences.extras
;
in: 2017.10

! Knot Hash

: part-1 ( seq -- n ) 1 (hash) first2 * ;

: part-2 ( seq -- str )
    hash [ >hex 2 char: 0 pad-head ] map-concat ;
