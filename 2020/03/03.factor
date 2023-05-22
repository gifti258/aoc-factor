USING: combinators combinators.smart kernel math sequences
sequences.extras ;
IN: 2020.03

! Toboggan Trajectory
! Count encountered trees

: count-trees ( seq n -- n )
    '[ _ * 31 mod swap nth CHAR: # = ] filter-index length ;

: part-1 ( seq -- n ) 3 count-trees ;

: count-trees* ( seq n -- n ) [ <evens> ] dip count-trees ;

: part-2 ( seq -- n )
    [ {
        [ 1 count-trees ]
        [ 3 count-trees ]
        [ 5 count-trees ]
        [ 7 count-trees ]
        [ 1 count-trees* ]
    } cleave ] [ * ] reduce-outputs ;
