using: accessors combinators.extras kernel math math.matrices
math.order math.vectors path-finding sequences ;
in: 2021.15

! Chiton
! Find path with the lowest risk

tuple: path < astar m ;
m: path cost ( from to astar -- n ) m>> matrix-nth nip ;
m: path heuristic ( from to astar -- n ) cost ;
m: path neighbors ( from astar -- seq )
    [ { { 1 0 } { -1 0 } { 0 1 } { 0 -1 } } [ v+ ] with map ]
    dip
    m>> dimension '[ _ [ 1 - 0 swap between? ] 2all? ] filter ;
: <path> ( m -- path ) path new swap >>m ;

: part-1 ( seq -- n )
    { 0 0 } swap
    [ dimension 1 v-n ]
    [ <path> find-path rest ]
    [ matrix-nths sum ] tri ;

: part-2 ( seq -- n )
    [ 5 5 ] dip '[
        + _ n+m [ 1 - 9 mod 1 + ] matrix-map
    ] <matrix-by-indices> [ stitch ] twice part-1 ;
