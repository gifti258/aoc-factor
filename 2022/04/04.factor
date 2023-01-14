using: kernel math.parser multiline peg.ebnf ranges sequences
sets sets.extras ;
in: 2022.04

! Camp Cleanup
! part 1: count assignment pairs in which one range fully
! contains the other
! part 2: count assignment pairs in which the ranges overlap

ebnf: parse [=[
    n = [0-9]+ => [[ dec> ]]
    range= n "-"~ n => [[ first2 [a..b] ]]
    pair= range ","~ range
]=]

: part-1 ( seq -- n )
    [ first2 [ subset? ] [ superset? ] 2bi or ] count ;

: part-2 ( seq -- n ) [ first2 intersects? ] count ;
