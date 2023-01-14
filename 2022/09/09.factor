using: arrays assocs kernel math math.order math.parser
math.vectors multiline peg.ebnf sequences sets ;
in: 2022.09

! Rope Bridge
! Number of unique positions visited by the rope tail 

constant: ch>v {
    { char: U { 0 +1 } }
    { char: D { 0 -1 } }
    { char: R { +1 0 } }
    { char: L { -1 0 } }
}

ebnf: parse [=[
    n = [0-9]+ => [[ dec> ]]
    dir = . => [[ ch>v at ]]
    line = dir " "~ n
]=]

: (part) ( seq n -- n )
    '[ hs{ { 0 0 } } clone _ { 0 0 } <array> ] dip [
        first2 swap '[
            unclip _ v+ [
                tuck v- dup [ abs 1 <= ] all?
                [ drop ] [ [ -1 1 clamp ] map v+ ] if
            ] accumulate swap [ pick adjoin ] keep suffix
        ] times
    ] each drop cardinality ;

: part-1 ( seq -- n ) 2 (part) ;

: part-2 ( seq -- n ) 10 (part) ;
