USING: kernel math math.matrices multiline peg.ebnf sequences ;
IN: 2022.02

! Rock Paper Scissors
! Sum scores (own move + outcome)
! part 1: opponent move/own move → outcome
! part 2: opponent move/outcome → own move

EBNF: parse [=[
    opponent = . => [[ CHAR: A - ]]
    self = . => [[ CHAR: X - ]]
    round = opponent " "~ self
]=]

MACRO: (part) ( quot m -- quot )
    '[ [ [ second @ ] [ _ matrix-nth ] bi + ] map-sum ] ;

: part-1 ( seq -- n )
    [ 1 + ] { { 3 6 0 } { 0 3 6 } { 6 0 3 } } (part) ;

: part-2 ( seq -- n )
    [ 3 * ] { { 3 1 2 } { 1 2 3 } { 2 3 1 } } (part) ;
