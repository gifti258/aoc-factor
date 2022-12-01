USING: assocs kernel math math.parser math.statistics multiline
peg.ebnf ranges sequences sequences.extras ;
IN: 2021.05

! Hydrothermal Venture
! Count number of points where at least 2 lines overlap

EBNF: parse [=[
	c = [0-9]+ => [[ dec> ]]
	p = c ","~ c
	rule = p " -> "~ p
]=]

: count-intersections ( seq -- n )
    [
        unzip [ first2 [a..b] ] bi@ 2dup [ length 1 = ] either?
        [ cartesian-product concat ] [ zip ] if
    ] map-concat histogram values [ 2 >= ] count ;

: part-1 ( seq -- n )
    [ first2 [ = ] 2any? ] filter count-intersections ;

: part-2 ( seq -- n ) count-intersections ;
