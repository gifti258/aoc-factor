USING: aoc.matrices arrays assocs biassocs kernel math
math.matrices math.order sequences.extras ;
IN: 2018.18

! Settlers of The North Pole
! Product of number of wooded acres and lumberyards after
! 10/1,000,000,000 minutes

: parse ( seq -- trees lumberyards )
    [ [ CHAR: | = 1 0 ? ] matrix-map ]
    [ [ CHAR: # = 1 0 ? ] matrix-map ] bi ;

:: step ( trees lumberyards -- trees' lumberyards' )
    trees lumberyards [ bitor 1 - abs ] matrix-2map :> open
    trees lumberyards [ neighbor-sum ] bi@
    [ [ 1 min ] bi@ bitand ] matrix-2map
    lumberyards [ bitand ] matrix-2map :> l->l
    trees neighbor-sum [ 3 >= 1 0 ? ] matrix-map
    open [ bitand ] matrix-2map :> o->t
    lumberyards neighbor-sum [ 3 >= 1 0 ? ] matrix-map
    trees [ bitand ] matrix-2map :> t->l
    trees t->l [ [-] ] matrix-2map :> t->t
    t->t o->t m+ l->l t->l m+ ;

: part-1 ( trees lumberyards -- n )
    10 [ step ] times [ matrix-sum ] bi@ * ;

: part-2 ( trees lumberyards -- n )
    0 <bihash> [
        [ step 2dup 2array ] [ 1 + ] [ pick over at dup ] tri*
    ] [ drop over roll pick set-at ] until [ 3drop ] 3dip
    1,000,000,000 over - roll pick - mod + swap value-at
    [ matrix-sum ] map-product ;
