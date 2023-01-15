using: aoc.input continuations kernel literals peg.ebnf
sequences sequences.extras splitting ;
in: 2020.19

! Monster messages

<<
ebnf: parse $[
    input-lines { "" } split first
    [ ":" "=" replace ] map "rule = 0" suffix join-lines
]

: part-1 ( -- n )
    input-lines { "" } split second
    [ [ parse ] [ 2drop f ] recover ] map-sift length ;
>>
