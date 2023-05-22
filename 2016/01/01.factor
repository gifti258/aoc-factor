USING: aoc.matrices assocs kernel math.matrices math.parser
math.vectors multiline peg.ebnf sequences sets ;
IN: 2016.01

! No Time for a Taxicab
! Distance to the Easter Bunny HQ
! part 1: distance to the final destination
! part 2: distance to the first destination visited twice

EBNF: parse [=[
    turn = ("R"|"L")
    length = ([0-9])+ => [[ dec> ]]
    direction = turn length (", "?)~
    rule = (direction)+
]=]

: turn ( v turn -- v' ) turns at vdotm ;

: part-1 ( seq -- n )
    [ { 0 1 } { 0 0 } ] dip [
        first2 [ turn ] [ overd v*n v+ ] bi-curry* bi*
    ] each nip l1-norm ;

: visited ( dir-seq -- pos-seq )
    [ { 0 1 } { 0 0 } ] dip [
        first2
        [ turn ] [ [ over v+ dup ] replicate ] bi-curry* bi*
    ] map 2nip concat ;

: part-2 ( seq -- n )
    visited { } swap
    [ unclip pick dupd in? ]
    [ [ suffix ] curry dip ] until 2nip l1-norm ;
