using: assocs kernel math sequences ;
in: 2015.01

! Not Quite Lisp
! Parentheses nesting depth
! part 1: total depth
! part 2: position of depth -1

: ch>n ( ch -- n ) { { char: ( 1 } { char: ) -1 } } at ;

: part-1 ( str -- n ) [ ch>n ] [ + ] map-reduce ;

: part-2 ( str -- n )
    0 [ ch>n + ] { } accumulate*-as -1 swap index 1 + ;
