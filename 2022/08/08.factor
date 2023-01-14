using: arrays kernel math math.matrices math.matrices.extras
ranges sequences sequences.extras ;
in: 2022.08

! Treetop Tree House
! part 1: count trees visible from outside
! part 2: maximum scenic score

:: tree-lines ( pos m -- seq )
    pos first2 :> ( x y )
    m dimension first2 :> ( xmax ymax )
    x 0 (a..b] x xmax (a..b) [ [ y 2array ] map ] bi@
    y 0 (a..b] y ymax (a..b) [ [ x swap 2array ] map ] bi@
    4array [ m matrix-nths ] map ;

: (part) ( m quot -- seq )
    '[
        [ tree-lines ] [ matrix-nth ] 2bi @
    ] cartesian-matrix-map concat ; inline

: part-1 ( m -- n )
    [ '[ [ t ] [ supremum _ < ] if-empty ] any? ] (part)
    [ ] count ;

: part-2 ( m -- n )
    [ '[
        dup [ _ >= ] find drop [ 1 + ] [ length ] ?if
    ] map-product ] (part) supremum ;
