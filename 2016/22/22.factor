using: aoc.matrices arrays assocs assocs.extras kernel math
math.combinatorics math.matrices math.parser math.vectors
multiline path-finding peg.ebnf sequences ;
in: 2016.22

! Grid Computing
! Count viable pairs

ebnf: (parse) [=[
    n = [0-9]+ => [[ dec> ]]
    node = "/dev/grid/node-x"~ n "-y"~ n (" "+)~
    size = n ("T" " "+)~
    percent = n "%"~
    line = node size~ size size percent~
]=]

: parse ( seq -- seq ) 2 tail [ (parse) ] map ;

: part-1 ( seq -- n )
    [ rest ] map 2 0 [
        concat first4 roll [ [ >= ] keep 0 > and 1 0 ? ] 2bi@ +
        +
    ] reduce-combinations ;
