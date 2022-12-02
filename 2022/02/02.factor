USING: assocs kernel math math.matrices sequences ;
IN: 2022.02

! Rock Paper Scissors
! Sum scores (own move + outcome)
! part 1: opponent move/own move → outcome
! part 2: opponent move/outcome → own move

CONSTANT: ch>index {
    { "A" 0 } { "B" 1 } { "C" 2 }
    { "X" 0 } { "Y" 1 } { "Z" 2 }
}

MACRO: (part) ( quot m -- quot )
    '[
        [ ch>index at ] matrix-map
        [ [ second @ ] [ _ matrix-nth ] bi + ] map-sum
    ] ;

: part-1 ( seq -- n )
    [ 1 + ] { { 3 6 0 } { 0 3 6 } { 6 0 3 } } (part) ;

: part-2 ( seq -- n )
    [ 3 * ] { { 3 1 2 } { 1 2 3 } { 2 3 1 } } (part) ;
