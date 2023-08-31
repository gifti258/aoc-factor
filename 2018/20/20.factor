USING: assocs assocs.extras combinators generalizations kernel
math math.order math.vectors sequences sets ;
IN: 2018.20

! A Regular Map
! part 1: find longest shortest path
! part 2: count paths of length >= 1000

: adjoin-at* ( value key assoc -- )
    [ [ V{ } clone ] unless* [ adjoin ] keep ] change-at ;

: add-neighbors ( neighbors stack pos quot -- neighbors' stack pos' )
    keep 2dup dupd [ 5 npick adjoin-at* ] 2bi@ ; inline

: build-neighbors ( str -- neighbors )
    [ H{ } V{ } { 0 0 } [ clone ] tri@ ] dip [ {
        { CHAR: N [ [ { 0 1 } v+ ] add-neighbors ] }
        { CHAR: S [ [ { 0 1 } v- ] add-neighbors ] }
        { CHAR: E [ [ { 1 0 } v+ ] add-neighbors ] }
        { CHAR: W [ [ { 1 0 } v- ] add-neighbors ] }
        { CHAR: ( [ [ over push ] keep ] }
        { CHAR: | [ drop dup last ] }
        { CHAR: ) [ over pop* ] }
        [ drop ]
    } case ] each 2drop ;

: extend-path ( path neighbors -- paths' )
    [ dup last ] dip at over without [ suffix ] with map ;

: add-paths ( paths paths' -- paths )
    [
        [ last ] [ length 1 - ] bi '[ 0 or _ max ] change-of
    ] each ;

: build-paths ( paths path neighbors -- )
    [ extend-path [ add-paths ] keep ] keep
    '[ _ build-paths ] with each ;

MEMO: (part) ( str -- lengths )
    [ H{ } clone dup { { 0 0 } } ] dip
    build-neighbors build-paths values ;

: part-1 ( str -- n ) (part) supremum ;

: part-2 ( str -- n ) (part) [ 1000 >= ] count ;
