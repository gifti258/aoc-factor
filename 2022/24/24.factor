using: aoc.matrices arrays hash-sets kernel math math.matrices
math.order math.vectors path-finding sequences sets slots.syntax
;
in: 2022.24

! Blizzard Basin
! Find shortest path through a valley full of blizzards

constant: neighbors* {
    { -1 0 } { 0 -1 } { 0 0 } { 0 1 } { 1 0 }
}

:: move-blizzards ( m n ch l op quot -- quot )
    m [ ch = ] matrix>pairs [
        first2 [ n op call 1 - l rem 1 + ] quot call 2array
    ] map ; inline

memo:: blizzard-positions ( m n -- set )
    m dimension { 2 2 } v- first2 :> ( h w )
    m n char: > w [ + ] [ call ] move-blizzards
    m n char: < w [ - ] [ call ] move-blizzards
    m n char: v h [ + ] [ dip ] move-blizzards
    m n char: ^ h [ - ] [ dip ] move-blizzards
    4array concat >hash-set ;

tuple: valley < astar goal m ;
m:: valley neighbors ( pos astar -- seq )
    pos first2 1 + :> ( pos n )
    astar get[ m goal ] :> ( m g )
    m dimension { 1 1 } v- :> d
    m n blizzard-positions :> blizzards
    neighbors* [ pos v+ ] map [
        d [ 0 swap between? ] 2all?
    ] filter [
        [ m matrix-nth char: # = ] [ blizzards in? ] bi or
    ] reject [ dup g = f n ? 2array ] map ;
m: valley cost ( from to astar -- n ) 3drop 1 ;
m: valley heuristic ( from to astar -- n ) 3drop 1 ;
: <valley> ( goal m -- astar )
    [ valley new ] 2dip [ >array ] map set[ goal m ] ;

memo:: find-path* ( start end n m -- n' )
    { start n } { end f } end m <valley> find-path
    length 1 - n + ;

: goal ( m -- pos )
    [ length 1 - ] [ last char: . swap index ] bi 2array ;

:: part-1 ( m -- n ) { 0 1 } m goal 0 m find-path* ;

:: part-2 ( m -- n )
    { 0 1 } :> s
    m goal :> e
    s e 0 m find-path* :> a
    e s a m find-path* :> b
    s e b m find-path* ;
