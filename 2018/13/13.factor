using: aoc.matrices arrays assocs grouping kernel literals math
math.matrices math.parser math.vectors sequences sets sorting ;
in: 2018.13

! Mine Cart Madness
! Position of the first crash/last remaining cart

constant: ch>turn {
    { char: / { { 0 -1 } { -1 0 } } }
    { char: \ { { 0 +1 } { +1 0 } } }
    { char: - { { +1 0 } { 0 +1 } } }
    { char: | { { +1 0 } { 0 +1 } } }
    { char: > { { +1 0 } { 0 +1 } } }
    { char: < { { +1 0 } { 0 +1 } } }
    { char: v { { +1 0 } { 0 +1 } } }
    { char: ^ { { +1 0 } { 0 +1 } } }
}

constant: turn>turn $[ {
    { { 0 -1 } { +1 0 } }
    { { +1 0 } { 0 +1 } }
    { { 0 +1 } { -1 0 } }
} 2 circular-clump ]

: setup ( m -- carts m' )
    flip [ [
        2array swap ch>direction at { { 0 -1 } { 1 0 } } 3array
    ] matrix-map-index concat sift-values ] keep ;

: move-cart ( cart m' -- cart' )
    [ first3 ] dip '[
        [ v+ ] keep over _ matrix-nth ch>turn at
    ] dip over [
        nip dup turn>turn at
    ] unless [ vdotm ] dip 3array ;

: format ( seq -- str ) first [ >dec ] map "," join ;

: part-1 ( m -- str )
    setup [ [ dup keys duplicates dup empty? ] ] dip '[
        drop [ _ move-cart ] map
    ] while nip format ;

: part-2 ( m -- str )
    setup [ [ dup length 1 = ] ] dip '[
        dup length [
            over [ dup [ _ move-cart ] when ] change-nth
            dup [ ?first ] map duplicates sift
            '[ [ ?first _ in? not ] keep and ] map
        ] each-integer sift sort-keys
    ] until first format ;
