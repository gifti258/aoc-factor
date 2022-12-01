USING: assocs grouping kernel math.combinatorics
math.parser multiline peg.ebnf sequences sets strings ;
IN: 2015.09

! All in a Single Night
! Find shortest and longest route between locations

EBNF: parse [=[
    str = [A-Za-z]+ => [[ >string ]]
    n = [0-9]+ => [[ dec> ]]
    pair = str " to "~ str
    distance = pair " = "~ n
]=]

: distances ( seq -- seq )
    [ [ first ] gather all-permutations ] keep
    dup [ unclip reverse prefix ] map append
    '[ 2 clump [ _ at ] map-sum ] map ;

: part-1 ( seq -- n ) distances infimum ;

: part-2 ( seq -- n ) distances supremum ;
