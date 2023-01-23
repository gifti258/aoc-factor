using: aoc.matrices arrays kernel math.parser sequences
sequences.extras sets splitting ;
in: 2017.24

! Electromagnetic Moat
! Find the strongest (longest) bridge

: parse ( seq -- seq' ) "/" split [ dec> ] map ;

: (max-bridge-strength) ( seq path quot: ( path -- obj ) -- n )
    dup '[
        unclip-last 3dup [ diff [ in? ] with filter ] dip
        over empty? [ 2drop nip @ ] [
            _ '[
                dup first2 [ nip _ = ] most [ suffix ] bi@
                _ (max-bridge-strength)
            ] 2with map-supremum
        ] if
    ] call ; inline recursive

: max-bridge-strength ( seq path -- n )
    [ matrix-sum ] (max-bridge-strength) ;

: max-bridge-strength* ( seq path -- n )
    [ [ length ] [ matrix-sum ] bi 2array ]
    (max-bridge-strength) ;

macro: (part) ( quot quot -- quot )
    '[
        dup [ 0 swap in? ] filter
        [ [ 1array ] [ supremum suffix ] bi ] map
        _ with map-supremum @
    ] ;

: part-1 ( seq -- n )
    [ max-bridge-strength ] [ ] (part) ;

: part-2 ( seq -- n )
    [ max-bridge-strength* ] [ second ] (part) ;
