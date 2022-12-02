USING: aoc.combinators.smart assocs assocs.extras grouping
kernel math math.matrices math.order math.parser math.statistics
math.vectors multiline peg.ebnf sequences sequences.extras sets
;
IN: 2017.20

! Particle Swarm
! part 1: Closest particle to <0,0,0> in the long term
! part 2: Number of remaining particles after collisions

EBNF: parse [=[
    n = [-0-9]+ => [[ dec> ]]
    triple = "=<"~ n ","~ n ","~ n ">"~
    particle = "p"~ triple ", v"~ triple ", a"~ triple
        => [[ reverse ]]
]=]

: part-1 ( seq -- n ) [ l1-norm ] matrix-map arg-min ;

: part-2 ( seq -- n )
    [ length ] keep [
       [ length ] keep rot pick [ > ] [ 1000 = ] bi or
    ] [
        [ { 0 0 0 } [ v+ ] accumulate* ] map
        [ [ third ] map duplicates ] keep
        [ third swap member? ] with reject
    ] while drop ;