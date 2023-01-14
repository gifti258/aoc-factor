using: assocs assocs.extras continuations grouping kernel math
math.parser multiline peg.ebnf sequences ;
in: 2017.25

! The Halting Problem
! Get diagnostic checksum from Turing machine blueprint

ebnf: parse-diagnostic [=[
    n = [0-9]+ => [[ dec> ]]
    line = "Perform a diagnostic checksum after "~ n " steps."~
]=]

ebnf: parse-write [=[
    line = "    - Write the value "~ . "."~ => [[ char: 1 = ]]
]=]

ebnf: parse-move [=[
    left = "left" => [[ -1 ]]
    right = "right" => [[ 1 ]]
    line = "    - Move one slot to the "~ (left|right) "."~
]=]

ebnf: parse-continue [=[
    line = "    - Continue with state "~ . "."~
        => [[ char: A - ]]
]=]

: parse ( paragraphs -- states n )
    unclip [
        [
            { 2 3 4 6 7 8 } swap nths 3 group [
                [
                    [ parse-write ]
                    [ parse-move ]
                    [ parse-continue ] tri*
                ] with-datastack
            ] map
        ] map
    ] [ second parse-diagnostic ] bi* ;

: part-1 ( rules n -- n )
    [ 0 h{ } clone 0 ] 2dip [
        4dup [ at 1 0 ? ] [ nth ] 2bi* nth first3
        [ '[ _ 2over set-at ] 2dip ]
        [ '[ _ + ] 3dip ]
        [ nipd swap ] tri*
    ] times 2drop nip 0 [ 1 0 ? + ] reduce-values ;
