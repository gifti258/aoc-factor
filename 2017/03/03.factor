USING: assocs kernel math math.functions math.matrices
math.vectors sequences ;
IN: 2017.03

! Spiral Memory
! part 1: find distance to given square
! part 2: squares are filled with neighbor sum, find first
! square greater than input

CONSTANT: coordinate-neighbors {
    { -1 -1 } { -1 0 } { -1 +1 } { 0 -1 }
    { 0 +1 } { +1 -1 } { +1 0 } { +1 +1 }
}

: part-1 ( n -- n )
    dup 1 - sqrt 1 - 2 /i [ 2 * 1 + sq - ]
    [ 1 + [ 2 * mod ] [ - abs ] [ + ] tri ] bi ;

: part-2 ( n -- n )
    [ { 1 0 } { 0 0 } H{ } clone 1 2 1 ] dip
    '[ pick _ > ] [
        [ 2over set-at [ dupd v+ ] dip ] 2dip
        1 - dup 0 = [
            drop 1 + dup 2/
            [ { { 0 1 } { -1 0 } } vdotm ] 4dip
        ] when [
            over coordinate-neighbors [ v+ ] with map
            over extract-keys values sift sum
        ] 2dip
    ] until 2drop 3nip ;
