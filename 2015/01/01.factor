USING: assocs kernel math sequences ;
IN: 2015.01

! Not Quite Lisp
! Parentheses nesting depth
! part 1: total depth
! part 2: position of depth -1

: ch>n ( ch -- n ) { { CHAR: ( 1 } { CHAR: ) -1 } } at ;

: part-1 ( str -- n ) [ ch>n ] map-sum ;

: part-2 ( str -- n )
    0 swap [ ch>n + dup -1 = ] find drop nip 1 + ;
