USING: assocs grouping kernel math math.parser multiline
peg.ebnf sequences splitting strings ;
IN: 2022.10

! Cathod-Ray Tube
! part 1: sample and sum signal strengths
! part 2: read letters from screen

EBNF: parse [=[
    n = [-0-9]+ => [[ dec> ]]
    noop = "noop" => [[ f ]]
    addx = "addx "~ n
    instruction = noop|addx
]=]

MACRO: record ( -- quot ) [ 3dup set-at [ 1 + ] dip ] ;

: (part) ( seq -- seq' )
    [ 1 1 H{ } clone ] dip [
        [ [ record record ] dip '[ _ + ] 2dip ] [ record ] if*
    ] each 2nip ;

: part-1 ( seq -- n )
    (part) { 20 60 100 140 180 220 } [ [ of ] keep * ] with map
    sum ;

: part-2 ( seq -- str )
    (part) 240 <iota> [
        [ 1 + of ] keep 40 mod - abs 1 <= CHAR: # CHAR: \s ?
    ] with map 40 group [ >string ] map join-lines ;
