USING: aoc.matrices arrays combinators kernel math
math.matrices math.parser multiline peg.ebnf sequences
sequences.extras splitting ;
IN: 2016.08

! Two-Factor Authentication
! Find the code that the display would have shown
! part 1: count the lit pixels
! part 2: which letters are shown?

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    rect = "rect" " "~ n "x"~ n
    rotate = "rotate "~ ("row"|"column") " "~ ("x"|"y")~ "="~ n
        " by "~ n
    op = (rect|rotate)
]=]

: display ( seq -- seq )
    6 50 <zero-matrix> swap [
        dup first {
            { "rect" [
                { 2 1 } swap nths <coordinate-matrix> concat
                1 swap pick matrix-set-nths
            ] }
            { "row" [
                [ second cut unclip ]
                [ third neg rotate 1array ] bi glue
            ] }
            { "column" [
                [ flip ] dip
                [ second cut unclip ]
                [ third neg rotate 1array ] bi glue flip
            ] }
        } case
    ] each ;

: part-1 ( seq -- n ) display matrix-sum ;

: part-2 ( seq -- str )
    display [ [ zero? 32 CHAR: * ? ] "" map-as ] map join-lines
    ;
