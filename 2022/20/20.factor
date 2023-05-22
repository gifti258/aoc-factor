USING: kernel math sequences sequences.extras ;
IN: 2022.20

! Grove Positioning System
! Sum of grove coordinates

: mix ( seq indices -- seq indices' )
    dup length <iota> [
        [ over index [ over length mod rotate rest ] keep ]
        [ reach nth '[ _ over length rem cut ] dip ]
        [ '[ _ prefix append ] dip over length rem rotate ] tri
    ] each ;

: coordinate-sum ( seq indices -- n )
    [ 0 over index ] dip tuck index rotate
    { 1000 2000 3000 } swap nths swap nths sum ;

MACRO: (part) ( n -- quot )
    '[ dup length <iota> _ [ mix ] times coordinate-sum ] ;

: part-1 ( seq -- n ) 1 (part) ;

: part-2 ( seq -- n ) [ 811,589,153 * ] map 10 (part) ;
