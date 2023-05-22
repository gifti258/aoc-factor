USING: aoc.matrices combinators kernel math sequences ;
IN: 2021.25

! Sea Cucumber
! Count steps until sea cucumbers stop moving

: cucumber-dot? ( ch1 ch2 ch -- ? )
    [ = ] curry [ CHAR: . = ] bi* and ;

:: move ( m ch -- m' )
    m [ matrix-rod ] [ ] [ matrix-rou ] tri [
        {
            { [ 2over ch cucumber-dot? ] [ 2drop ] }
            { [ 2dup ch cucumber-dot? ] [ 2nip ] }
            [ drop nip ]
        } cond
    ] matrix-3map ;

: south ( m -- m' ) CHAR: v move ;
: east ( m -- m' ) flip CHAR: > move flip ;
: step ( m -- m' ) east south ;

: part-1 ( m -- n )
    0 swap [ [ 1 + ] dip [ step dup ] keep = not ] loop drop ;
