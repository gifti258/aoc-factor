using: combinators combinators.extras kernel math math.matrices
math.matrices.extras math.parser math.vectors multiline peg.ebnf
sequences strings ;
in: 2020.12

! Rain Risk
! Find distance between start and end point

ebnf: parse [=[
    n = [0-9]+ => [[ dec> ]]
    action = [NSEWLRF] => [[ 1string ]]
    instruction = action n
]=]

macro: (part) ( quot -- quot )
    [ dup ] thrice '[ [ first2 swap {
        { "N" [ { 0 +1 } n*v @ ] }
        { "S" [ { 0 -1 } n*v @ ] }
        { "E" [ { +1 0 } n*v @ ] }
        { "W" [ { -1 0 } n*v @ ] }
        { "L" [ 90 / { { 0 -1 } { +1 0 } } n^m swap mdotv ] }
        { "R" [ 90 / { { 0 +1 } { -1 0 } } n^m swap mdotv ] }
        { "F" [ over n*v '[ _ v+ ] dip ] }
    } case ] each drop l1-norm ] ;

: part-1 ( seq -- n )
    [ { 0 0 } { 1 0 } ] dip [ '[ _ v+ ] dip ] (part) ;

: part-2 ( seq -- n ) [ { 0 0 } { 10 1 } ] dip [ v+ ] (part) ;
