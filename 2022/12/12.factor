using: accessors aoc.matrices arrays assocs combinators kernel
math math.matrices math.order math.vectors path-finding
sequences sequences.extras ;
in: 2022.12

! Hill Climbing Algorithm
! part 1: find shortest path length from S to E
! part 2: find shortest path length from any a to E

tuple: signal < astar map ;
m: signal neighbors
    map>> [
        [
            cardinal-coordinate-neighbors
        ] dip [ '[
            _ dimension [ 1 - 0 swap between? ] 2all?
        ] filter ] keep
    ] [
        matrix-nth '[ _ matrix-nth _ 1 + <= ] filter
    ] 2bi ;
m: signal cost 3drop 1 ;
m: signal heuristic 3drop 1 ;
: <signal> ( m -- astar )
    signal new swap [ { "Sa" "Ez" } substitute ] map >>map ;

: matrix-indices ( m elt -- seq )
    '[ 2array [ _ = ] dip and ] matrix-map-index concat sift ;

: matrix-index ( m elt -- pos ) matrix-indices first ;

: part-1 ( m -- n )
    [ >array ] map
    [ char: S matrix-index ]
    [ char: E matrix-index ]
    [ <signal> ] tri find-path length 1 - ;

: path-length ( pos m -- n )
    [ char: E matrix-index ] [ <signal> ] bi find-path
    dup [ length 1 - ] when ;

: part-2 ( m -- n )
    [ >array ] map [ char: a matrix-indices ] keep
    '[ _ path-length ] map ?infimum ;
