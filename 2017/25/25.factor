USING: aoc.combinators.smart arrays assocs assocs.extras
grouping kernel math math.parser multiline peg.ebnf sequences ;
IN: 2017.25

! The Halting Problem
! Get diagnostic checksum from Turing machine blueprint

EBNF: parse-diagnostic [=[
    n = [0-9]+ => [[ dec> ]]
    line = "Perform a diagnostic checksum after "~ n " steps."~
]=]

EBNF: parse-write [=[
    line = "    - Write the value "~ . "."~ => [[ CHAR: 1 = ]]
]=]

EBNF: parse-move [=[
    left = "left" => [[ -1 ]]
    right = "right" => [[ 1 ]]
    line = "    - Move one slot to the "~ (left|right) "."~
]=]

EBNF: parse-continue [=[
    line = "    - Continue with state "~ . "."~
        => [[ CHAR: A - ]]
]=]

: parse ( paragraphs -- states n )
    unclip [
        [
            { 2 3 4 6 7 8 } swap nths 3 group [
                [
                    [ parse-write ]
                    [ parse-move ]
                    [ parse-continue ] tri*
                ] sequence>array
            ] map
        ] map
    ] [ second parse-diagnostic ] bi* ;

: part-1 ( rules n -- n )
    [ 0 H{ } clone 0 ] 2dip [
        4dup [ at 1 0 ? ] [ nth ] 2bi* nth first3
        [ '[ _ 2over set-at ] 2dip ]
        [ '[ _ + ] 3dip ]
        [ nipd swap ] tri*
    ] times 2drop nip 0 [ 1 0 ? + ] reduce-values ;
