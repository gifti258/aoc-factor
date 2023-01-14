using: aoc.matrices arrays combinators kernel math
math.matrices math.parser multiline peg.ebnf sequences
sequences.extras splitting ;
in: 2016.08

! Two-Factor Authentication
! Find the code that the display would have shown
! part 1: count the lit pixels
! part 2: which letters are shown?

ebnf: parse [=[
    n = [0-9]+ => [[ dec> ]]
    rect = "rect" " "~ n "x"~ n
    rotate = "rotate "~ ("row"|"column") " "~ ("x"|"y")~ "="~ n
        " by "~ n
    op = (rect|rotate)
]=]

: rotate* ( m seq -- m' )
    first2 [ cut unclip ] [ neg rotate 1array ] bi* glue ;

: display ( seq -- seq )
    6 50 <zero-matrix> swap [
        unclip {
            { "rect" [
                reverse <coordinate-matrix> concat
                1 swap pick matrix-set-nths
            ] }
            { "row" [ rotate* ] }
            { "column" [ [ flip ] dip rotate* flip ] }
        } case
    ] each ;

: part-1 ( seq -- n ) display matrix-sum ;

: part-2 ( seq -- str )
    display [
        [ zero? 32 char: * ? ] "" map-as
    ] map join-lines ;
