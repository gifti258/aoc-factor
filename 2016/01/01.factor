USING: assocs aoc.input kernel math math.matrices math.parser
math.vectors multiline peg.ebnf sequences ;
IN: 2016.01

! No Time for a Taxicab
! Find the location of Easter Bunny HQ
! part 1: find final destination
! part 2: find first destination visited twice

<<
EBNF: parse [=[
    turn = ("R"|"L")
    length = ([0-9])+ => [[ dec> ]]
    direction = turn length (", "?)~
    rule = (direction)+
]=]

: input ( -- seq ) input-line parse ;
>>

: turn ( v turn -- v' )
    {
        { "L" { { 0 1 } { -1 0 } } }
        { "R" { { 0 -1 } { 1 0 } } }
    } at vdotm ;

: blocks ( v -- blocks ) [ abs ] map-sum ;

: part-1 ( seq -- blocks )
    [ { 0 1 } { 0 0 } ] dip [
        first2 [ turn ] [ overd v*n v+ ] bi-curry* bi*
    ] each nip blocks ;

: visited ( dir-seq -- pos-seq )
    [ { 0 1 } { 0 0 } ] dip [
        first2
        [ turn ]
        [ [ over v+ dup ] replicate ] bi-curry* bi*
    ] map 2nip concat ;

: part-2 ( seq -- blocks )
    visited { } swap
    [ unclip pick dupd member? ]
    [ [ suffix ] curry dip ] until 2nip blocks ;
