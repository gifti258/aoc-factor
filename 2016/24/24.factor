using: accessors aoc.input aoc.matrices arrays ascii assocs
assocs.extras combinators.short-circuit grouping kernel literals
math math.combinatorics math.matrices math.order path-finding
sequences ;
in: 2016.24

! Air Duct Spelunking
! Shortest way to collect all numbers

tuple: numbers < astar m ;
m: numbers neighbors ( node astar -- seq )
    [ cardinal-coordinate-neighbors ] dip m>> '[ _ {
        [ dimension [ 1 - 0 swap between? ] 2all? ]
        [ matrix-nth [ char: . = ] [ digit? ] bi or ]
    } 2&& ] filter ;
m: numbers cost ( from to astar -- n ) 3drop 1 ;
m: numbers heuristic ( from to astar -- n ) 3drop 1 ;

: input ( -- m ) $[ input-lines [ >array ] map ] ;

: <numbers> ( -- astar ) numbers new input >>m ;

memo: number-positions ( -- assoc )
    input [ 2array [ 2array ] keepd digit? swap and ]
    matrix-map-index concat sift ;

memo: paths ( -- assoc )
    number-positions 2 [
        unzip first2 <numbers> find-path length 1 -
    ] h{ } map>assoc-combinations
    dup [ reverse ] map-keys assoc-union ;

: count-paths ( quot -- n )
    [ char: 0 number-positions keys remove f ] dip '[
        char: 0 prefix @ 2 clump [ paths at ] map-sum
        over [ min ] [ or ] if
    ] reduce-permutations ; inline

: part-1 ( -- n ) [ ] count-paths ;

: part-2 ( -- n ) [ char: 0 suffix ] count-paths ;
