USING: combinators kernel math math.parser multiline peg.ebnf
sequences ;
IN: 2019.22

! Slam Shuffle
! Position of card 2019

SYMBOLS: +cut+ +inc+ +new+ ;

EBNF: parse [=[
    n = [-0-9]+ => [[ dec> ]]
    cut = "cut "~ n:n => [[ { +cut+ n } ]]
    inc = "deal with increment "~ n:n => [[ { +inc+ n } ]]
    new = "deal into new stack"~ => [[ { +new+ } ]]
    line = cut|inc|new
]=]

: shuffle ( length pos seq n -- pos' )
    [
        [
            [
                unclip {
                    { +cut+ [ first - over rem ] }
                    { +inc+ [ first * over mod ] }
                    { +new+ [ drop dupd - 1 - ] }
                } case
            ] each
        ] keep
    ] times drop nip ;

: part-1 ( seq -- n ) [ 10,007 2019 ] dip 1 shuffle ;
