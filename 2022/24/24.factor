USING: aoc.matrices arrays hash-sets kernel math math.matrices
math.order math.vectors path-finding sequences sets slots.syntax
;
IN: 2022.24

! Blizzard Basin
! Find shortest path through a valley full of blizzards

CONSTANT: neighbors* {
    { -1 0 } { 0 -1 } { 0 0 } { 0 1 } { 1 0 }
}

:: move-blizzards ( m n ch l op quot -- quot )
    m [ ch = ] matrix>pairs [
        first2 [ n op call 1 - l rem 1 + ] quot call 2array
    ] map ; inline

MEMO:: blizzard-positions ( m n -- set )
    m dimension { 2 2 } v- first2 :> ( h w )
    m n CHAR: > w [ + ] [ call ] move-blizzards
    m n CHAR: < w [ - ] [ call ] move-blizzards
    m n CHAR: v h [ + ] [ dip ] move-blizzards
    m n CHAR: ^ h [ - ] [ dip ] move-blizzards
    4array concat >hash-set ;

TUPLE: valley < astar goal m ;
M:: valley neighbors ( pos astar -- seq )
    pos first2 1 + :> ( pos n )
    astar get[ m goal ] :> ( m g )
    m dimension { 1 1 } v- :> d
    m n blizzard-positions :> blizzards
    neighbors* [ pos v+ ] map [
        d [ 0 swap between? ] 2all?
    ] filter [
        [ m matrix-nth CHAR: # = ] [ blizzards in? ] bi or
    ] reject [ dup g = f n ? 2array ] map ;
M: valley cost ( from to astar -- n ) 3drop 1 ;
M: valley heuristic ( from to astar -- n ) 3drop 1 ;
: <valley> ( goal m -- astar )
    [ valley new ] 2dip [ >array ] map set[ goal m ] ;

MEMO:: find-path* ( start end n m -- n' )
    { start n } { end f } end m <valley> find-path
    length 1 - n + ;

: goal ( m -- pos )
    [ length 1 - ] [ last CHAR: . swap index ] bi 2array ;

:: part-1 ( m -- n ) { 0 1 } m goal 0 m find-path* ;

:: part-2 ( m -- n )
    { 0 1 } :> s
    m goal :> e
    s e 0 m find-path* :> a
    e s a m find-path* :> b
    s e b m find-path* ;
