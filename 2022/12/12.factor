USING: accessors aoc.matrices arrays assocs combinators kernel
math math.matrices math.order math.vectors path-finding
sequences sequences.extras ;
IN: 2022.12

! Hill Climbing Algorithm
! part 1: find shortest path length from S to E
! part 2: find shortest path length from any a to E

TUPLE: signal < astar map ;
M: signal neighbors
    map>> [
        [
            cardinal-coordinate-neighbors
        ] dip [ '[
            _ dimension [ 1 - 0 swap between? ] 2all?
        ] filter ] keep
    ] [
        matrix-nth '[ _ matrix-nth _ 1 + <= ] filter
    ] 2bi ;
M: signal cost 3drop 1 ;
M: signal heuristic 3drop 1 ;
: <signal> ( m -- astar )
    signal new swap [ { "Sa" "Ez" } substitute ] map >>map ;

: matrix-indices ( m elt -- seq )
    '[ 2array [ _ = ] dip and ] matrix-map-index concat sift ;

: matrix-index ( m elt -- pos ) matrix-indices first ;

: part-1 ( m -- n )
    [ >array ] map
    [ CHAR: S matrix-index ]
    [ CHAR: E matrix-index ]
    [ <signal> ] tri find-path length 1 - ;

: path-length ( pos m -- n )
    [ CHAR: E matrix-index ] [ <signal> ] bi find-path
    dup [ length 1 - ] when ;

: part-2 ( m -- n )
    [ >array ] map [ CHAR: a matrix-indices ] keep
    '[ _ path-length ] map ?infimum ;
