USING: 2017.knothash math math.parser sequences sequences.extras
;
IN: 2017.10

! Knot Hash

: part-1 ( seq -- n ) 1 (hash) first2 * ;

: part-2 ( seq -- str )
    hash [ >hex 2 CHAR: 0 pad-head ] map-concat ;
