USING: arrays assocs kernel math math.order math.parser
math.vectors multiline peg.ebnf sequences sets ;
IN: 2022.09

! Rope Bridge
! Number of unique positions visited by the rope tail 

CONSTANT: ch>v {
    { CHAR: U { 0 +1 } }
    { CHAR: D { 0 -1 } }
    { CHAR: R { +1 0 } }
    { CHAR: L { -1 0 } }
}

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    dir = . => [[ ch>v at ]]
    line = dir " "~ n
]=]

: (part) ( seq n -- n )
    '[ HS{ { 0 0 } } clone _ { 0 0 } <array> ] dip [
        first2 swap '[
            unclip _ v+ [
                tuck v- dup [ abs 1 <= ] all?
                [ drop ] [ [ -1 1 clamp ] map v+ ] if
            ] accumulate swap [ pick adjoin ] keep suffix
        ] times
    ] each drop cardinality ;

: part-1 ( seq -- n ) 2 (part) ;

: part-2 ( seq -- n ) 10 (part) ;
