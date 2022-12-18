using: arrays deques dlists kernel math math.combinatorics
math.order math.parser math.statistics math.vectors sequences
sequences.generalizations sets splitting ;
in: 2022.18

: parse ( line -- seq ) "," split [ dec> ] map ;

: part-1 ( seq -- n )
    [ length 6 * ] [
        2 0 [
            first2 v- l1-norm 1 = 1 0 ? +
        ] reduce-combinations 2 *
    ] bi - ;

constant: neighbors {
    { 0 0 +1 } { 0 +1 0 } { +1 0 0 }
    { 0 0 -1 } { 0 -1 0 } { -1 0 0 }
}

:: part-2 ( seq -- n )
    seq flip [ minmax 2array ] map
    flip first2 1 [ v-n ] [ v+n ] bi-curry bi* :> ( b1 b2 )
    hs{ } clone :> visited
    v{ } clone :> cubes
    b1 1dlist :> queue
    queue [ :> pos
        pos visited in? [
            pos visited adjoin
            pos seq in? [
                pos cubes push
                pos neighbors [
                    v+ :> neighbor
                    neighbor b1 b2 [ between? ] 3 nall? [
                        neighbor queue push-front
                    ] when
                ] with each
            ] unless
        ] unless
    ] slurp-deque cubes part-1
    b2 b1 v- 1 v+n 2 0 [ product + ] reduce-combinations 2 * - ;
