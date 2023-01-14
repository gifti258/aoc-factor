using: assocs grouping.extras kernel math sequences ;
in: 2015.10

! Elves Look, Elves Say
! Look-and-say sequence

: look-and-say ( seq n -- n )
    [
        [ ] group-by [ length swap ] assoc-map concat
    ] times length ;

: part-1 ( seq -- n ) 40 look-and-say ;

: part-2 ( seq -- n ) 50 look-and-say ;
