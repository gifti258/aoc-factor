using: aoc.matrices assocs assocs.extras hash-sets kernel math
math.statistics math.vectors sequences sequences.extras sets ;
in: 2022.23

! Unstable Diffusion
! Space out elves so that they don't have any direct neighbors
! part 1: number of empty ground tiles in smallest rectangle
! containing all elfs
! part 2: number of rounds until elves stop moving

: parse ( m -- seq ) [ 1 = ] matrix>pairs >hash-set ;

constant: neighbors {
    { 0 +1 } { +1 +1 }
    { +1 0 } { +1 -1 }
    { -1 0 } { -1 +1 }
    { 0 -1 } { -1 -1 }
}

constant: moves {
    { { -1 0 } { -1 -1 } { -1 +1 } }
    { { +1 0 } { +1 -1 } { +1 +1 } }
    { { 0 -1 } { -1 -1 } { +1 -1 } }
    { { 0 +1 } { -1 +1 } { +1 +1 } }
}

:: round ( set moves -- set' ? )
    H{ } clone :> assoc set members [ :> pos
        neighbors [ pos v+ ] map set intersects? [
            moves [
                [ pos v+ ] map
                [ set intersects? not ] [ first ] bi and
            ] map-find drop [ pos swap assoc push-at ] when*
        ] when
    ] each moves 1 rotate! assoc [
        dup length 1 = [
            first set delete set adjoin
        ] [ 2drop ] if
    ] assoc-each set assoc [ length 1 = ] assoc-any-value? ;

: part-1 ( set -- n )
    10 moves clone '[ _ round drop ] times members
    [ flip [ minmax swap - 1 + ] map product ]
    [ length ] bi - ;

: part-2 ( set -- n )
    0 swap moves clone '[ [ 1 + ] [ _ round ] bi* ] loop drop ;
