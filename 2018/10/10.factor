USING: aoc.matrices assocs kernel math math.parser
math.statistics math.vectors multiline peg.ebnf sequences ;
IN: 2018.10

! The Stars Align
! part 1: read message spelled out by the moving lights
! part 2: count steps until message appears

EBNF: parse [=[
    n = [ 0-9-]+ => [[ [ 32 = ] trim dec> ]]
    pair = "<"~ n ", "~ n ">"~
    point = "position="~ pair " velocity="~ pair
]=]

: next-constellation ( seq -- seq' ) [ [ v+ ] keep ] assoc-map ;

: dimensions ( seq -- dim ) keys flip [ range ] map ;

: find-message ( seq -- n seq' )
    0 swap [
        dup next-constellation
        2dup [ dimensions ] bi@
        v>= vall?
        [ [ nip [ 1 + ] dip ] [ drop ] if ] keep
    ] loop ;

: part-1 ( seq -- str )
    find-message nip
    keys dup flip [ infimum ] map '[ _ v- ] map matrix-format ;

: part-2 ( seq -- n ) find-message drop ;
