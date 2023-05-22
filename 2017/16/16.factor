USING: aoc.input arrays assocs combinators kernel literals math
math.parser multiline peg.ebnf sequences sequences.extras sets
splitting ;
IN: 2017.16

! Permutation Promenade
! Dancing programs

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    spin = "s" n
    exchange = "x" n "/"~ n
    partner = "p" . "/"~ .
    move = spin|exchange|partner
]=]

CONSTANT: start "abcdefghijklmnop"

: input ( -- seq ) $[ input-line ] "," split [ parse ] map ;

MEMO: permute ( str -- str )
    clone input [
        unclip {
            { "s" [ first neg rotate ] }
            { "x" [ first2 pick exchange ] }
            { "p" [ dup reverse 2array substitute ] }
        } case
    ] each ;

: part-1 ( -- str ) start permute ;

: part-2 ( -- str )
    start { } [ 2dup in? ] [
        over suffix [ permute ] dip
    ] until nip [ length 1,000,000,000 swap mod ] keep nth ;
