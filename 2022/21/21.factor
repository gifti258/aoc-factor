USING: assocs inverse kernel math math.parser multiline peg.ebnf
quotations sequences sequences.deep strings ;
IN: 2022.21

! Monkey Math
! part 1: number yelled by root
! part 2: number to be yelled by humn so that root branches are
! equal

EBNF: parse [=[
    str = [a-z]+ => [[ >string ]]
    n = [0-9]+ => [[ dec> ]]
    op = [-+*/] => [[ 1string ]]
    expr = str:a " "~ op:op " "~ str:b => [[ { a b op } ]]
    line = str ": "~ (n|expr)
]=]

CONSTANT: str->op {
    { "+" [ + ] }
    { "-" [ - ] }
    { "*" [ * ] }
    { "/" [ / ] }
}

:: lookup ( assoc key -- n )
    assoc key of dup number? [
        first3 [ [ assoc swap lookup ] bi@ ] dip
        str->op at call( x x -- x )
    ] unless ;

: part-1 ( assoc -- n ) "root" lookup ;

SYMBOL: +humn+

:: lookup* ( assoc key -- quot )
    assoc key of dup sequence? [
        first3 [
            [ assoc swap lookup* ] bi@
        ] dip dup "=" = [
            drop call( -- x ) swap rest [undo] call( x -- x )
        ] [
            str->op at over [ +humn+ = ] deep-find [
                swapd [ swap ] prepose
            ] when compose compose
        ] if
    ] [ 1quotation ] if ;

: part-2 ( assoc -- n )
    "root" over [ "=" 2 pick set-nth ] change-at
    +humn+ "humn" pick set-at "root" lookup* ;
