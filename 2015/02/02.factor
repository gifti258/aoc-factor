USING: kernel math math.combinatorics math.parser
multiline peg.ebnf sequences sorting ;
IN: 2015.02

! I Was Told There Would Be No Math
! Calculate amount of wrapping paper and ribbon needed

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    rule = n "x"~ n "x"~ n
]=]

: paper ( seq -- n )
    2 [ product ] map-combinations
    [ sum 2 * ] [ infimum ] bi + ;

: ribbon ( seq -- n )
    [ natural-sort first2 + 2 * ] [ product ] bi + ;

: part-1 ( seq -- n ) [ paper ] map-sum ;

: part-2 ( seq -- n ) [ ribbon ] map-sum ;
