USING: aoc.input arrays assocs assocs.extras grouping kernel
math math.statistics multiline peg.ebnf sequences strings ;
IN: 2021.14

! Extended Polymerization
! Substitute string 10/40 times, difference between most and
! least common character

<<
EBNF: parse [=[
    pair = . . => [[ >string ]]
    rule = pair " -> "~ .
]=]

: input ( -- str rules )
    input-2paragraphs [ first ] [ [ parse ] map ] bi* ;
>>

: pair-insertion ( str rules n -- n )
    [ 2 clump histogram ] 2dip [
        [ '[ [
            [ 1 cut ] keep _ at
            [ suffix ] [ prefix ] bi-curry bi* 2array
        ] dip ] collect-assoc-by-multi [ sum ] map-values ] keep
    ] times drop [ ] collect-assoc-by-multi
    [ sum 1 + 2/ ] map-values values minmax - neg ;

: part-1 ( str rules -- n ) 10 pair-insertion ;

: part-2 ( str rules -- n ) 40 pair-insertion ;
