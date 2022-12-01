USING: aoc.input assocs kernel math.vectors sequences
sequences.extras sets ;
IN: 2015.03

! Perfectly Spherical Houses in a Vacuum
! part 1: count unique houses
! part 2: Santa and Robo-Santa take turns following the
! instructions

<<
: input ( -- seq )
    input-line [ {
        { CHAR: ^ { 0 -1 } } { CHAR: v { 0 1 } }
        { CHAR: > { 1 0 } } { CHAR: < { -1 0 } }
    } at ] { } map-as ;
>>

: locations ( seq -- seq' )
    { 0 0 } [ v+ ] accumulate swap suffix ;

: part-1 ( seq -- n ) locations cardinality ;

: part-2 ( seq -- n )
    [ <evens> ] [ <odds> ] bi [ locations ] bi@ union
    cardinality ;
