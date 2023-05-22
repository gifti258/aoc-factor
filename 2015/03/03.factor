USING: aoc.matrices assocs kernel math.vectors sequences
sequences.extras sets ;
IN: 2015.03

! Perfectly Spherical Houses in a Vacuum
! Count unique houses
! part 2: Santa and Robo-Santa take turns following the
! instructions

: parse ( str -- seq ) [ ch>direction at ] { } map-as ;

: locations ( seq -- seq' )
    { 0 0 } [ v+ ] accumulate swap suffix ;

: part-1 ( seq -- n ) locations cardinality ;

: part-2 ( seq -- n )
    [ <evens> ] [ <odds> ] bi [ locations ] bi@ union
    cardinality ;
