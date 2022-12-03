USING: math.parser sequences ;
IN: aoc.math.parser

: dec>digits ( n -- seq ) [ digit> ] { } map-as ;

: digits>dec ( seq -- str ) [ >digit ] "" map-as ;

: >digits ( n -- seq ) >dec dec>digits ;

: digits> ( seq -- n ) digits>dec dec> ;
