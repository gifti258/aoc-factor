USING: aoc.input arrays assocs assocs.extras kernel math
math.parser math.statistics multiline peg.ebnf ranges sequences
sequences.generalizations sets ;
IN: 2018.03

<<
EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    claim = "#"~ n " @ "~ n ","~ n ": "~ n "x"~ n
]=]

: input ( -- seq )
    input-lines [
        parse 5 firstn swapd [ dupd + [a..b) ] 2bi@
        cartesian-product concat 2array
    ] map ;
>>

: part-1 ( seq -- n )
    values concat histogram values [ 1 > ] count ;

: part-2 ( seq -- n )
    [ length [1..b] ] keep [ reverse ] map
    [ ] collect-assoc-by-multi [ length 1 > ] filter-values
    values union-all diff first ;
