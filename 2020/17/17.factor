USING: aoc.matrices arrays hash-sets kernel math
math.combinatorics math.statistics math.vectors ranges sequences
sequences.product sets ;
IN: 2020.17

! Conway Cubes
! Number of cubes in active state after 6 cycles

MEMO: neighbors ( dims -- seq )
    { -1 0 1 } swap all-selections [ [ 0 = ] all? ] reject ;

:: cycle ( set dims -- set' )
    HS{ } clone :> set'
    set members flip [
        minmax [ 1 - ] [ 1 + ] bi* [a..b]
    ] map [ :> pos
        dims neighbors [ pos v+ ] map set intersect cardinality
        pos set in? [ { 2 3 } in? ] [ 3 = ] if
        [ pos set' adjoin ] when
    ] product-each set' ;

:: (part) ( m dims -- n )
    m [ 1 = ] matrix>pairs [ dims 2 - 0 <array> append ] map
    >hash-set 6 [ dims cycle ] times cardinality ;

: part-1 ( m -- n ) 3 (part) ;

: part-2 ( m -- n ) 4 (part) ;
