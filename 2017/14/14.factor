USING: 2017.10 aoc.groups aoc.matrices kernel math math.parser
math.vectors sequences sequences.extras ;
IN: 2017.14

! Disk Defragmentation
! Count used squares and regions

: grid ( str -- seq )
    128 <iota> [ >dec "-" glue hash ] with map ;

: part-1 ( str -- n )
    grid [ >bin [ CHAR: 1 = ] count ] matrix-map-sum ;

: part-2 ( str -- n )
    grid [ [ >bin 8 CHAR: 0 pad-head ] { } map-concat-as ] map
    [ CHAR: 1 = ] matrix>pairs
    [ v- [ abs ] map-sum 1 = ] count-groups ;
