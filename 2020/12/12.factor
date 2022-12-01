USING: combinators kernel math math.matrices
math.matrices.extras math.parser math.vectors multiline peg.ebnf
sequences strings ;
IN: 2020.12

! Rain Risk
! Find distance between start and end point

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    action = [NSEWLRF] => [[ 1string ]]
    instruction = action n
]=]

: part-1 ( seq -- n )
    [ { 0 0 } { 1 0 } ] dip [ first2 swap {
        { "N" [ { 0 1 } n*v [ v+ ] curry dip ] }
        { "S" [ { 0 -1 } n*v [ v+ ] curry dip ] }
        { "E" [ { 1 0 } n*v [ v+ ] curry dip ] }
        { "W" [ { -1 0 } n*v [ v+ ] curry dip ] }
        { "L" [ 90 / { { 0 -1 } { 1 0 } } n^m swap mdotv ] }
        { "R" [ 90 / { { 0 1 } { -1 0 } } n^m swap mdotv ] }
        { "F" [ over n*v [ v+ ] curry dip ] }
    } case ] each drop [ abs ] map-sum ;

: part-2 ( seq -- n )
    [ { 0 0 } { 10 1 } ] dip [ first2 swap {
        { "N" [ { 0 1 } n*v v+ ] }
        { "S" [ { 0 -1 } n*v v+ ] }
        { "E" [ { 1 0 } n*v v+ ] }
        { "W" [ { -1 0 } n*v v+ ] }
        { "L" [ 90 / { { 0 -1 } { 1 0 } } n^m swap mdotv ] }
        { "R" [ 90 / { { 0 1 } { -1 0 } } n^m swap mdotv ] }
        { "F" [ over n*v [ v+ ] curry dip ] }
    } case ] each drop [ abs ] map-sum ;
