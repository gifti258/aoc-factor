using: aoc.input aoc.matrices kernel math math.parser multiline
peg.ebnf sequences sets ;
in: 2021.13

! Transparent Origami
! Fold transparent paper
! part 1: fold once, count points
! part 2: fold completely, read activation code

ebnf: (parse) [=[
    n = [0-9]+ => [[ dec> ]]
    instruction = "fold along "~ . "="~ n
]=]

: parse ( paragraph1 paragraph2 -- points instructions )
    [ [ csn-line ] map ] [ [ (parse) ] map ] bi* ;

: fold ( points instruction -- points' )
    first2 [ char: x = 0 1 ? ] dip 2dup '[
        _ over nth _ >
        [ _ over [ _ 2 * swap - ] change-nth ] when
    ] map ;

: part-1 ( points instructions -- n ) first fold cardinality ;

: part-2 ( points instructions -- str )
    [ fold ] each matrix-format ;
