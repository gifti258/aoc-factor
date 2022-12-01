USING: aoc.input kernel math math.parser multiline peg.ebnf
sequences ;
IN: 2015.25

! Let It Snow
! Find code on an infinite sheet of paper

<< EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    input = "To continue, please consult the code grid in the "~
        "manual.  Enter the code at row "~ n ", column "~ n "."~
]=]

: input ( -- row col ) input-line parse first2 ; >>

: part-1 ( row col -- n )
    [ + <iota> sum ] keepd - 20151125 swap
    [ 252533 * 33554393 mod ] times ;
