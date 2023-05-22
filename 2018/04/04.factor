USING: arrays assocs combinators kernel math math.parser
multiline peg.ebnf ranges sequences sorting ;
IN: 2018.04

! Repose Record
! part 1: find guard that is asleep the most
! part 2: find guard that is most asleep on the same minute

SYMBOLS: +guard+ +asleep+ +awake+ ;

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    ts = "["~ n~ "-"~ n~ "-"~ n~ " "~ n~ ":"~ n "] "~
    begin = ts~ "Guard #"~ n:n " begins shift"~
        => [[ { +guard+ n } ]]
    fall-asleep = ts:s "falls asleep"~
        => [[ { +asleep+ s } ]]
    wake-up = ts:s "wakes up"~ => [[ { +awake+ s } ]]
    line = begin|fall-asleep|wake-up
]=]

: tally ( seq -- assoc )
    [ H{ } clone f f ] dip natural-sort [ parse ] map [
        first2 swap {
            { +guard+ [ spin drop ] }
            { +asleep+ [ nip ] }
            { +awake+ [ [a..b) [
                2over -rot
                [ H{ } clone or tuck inc-at ] with change-at
            ] each f ] }
        } case
    ] each 2drop ;

: part-1 ( seq -- n )
    tally dup [ values sum ] assoc-map
    [ values supremum ] keep value-at
    [ of [ values supremum ] keep value-at ] keep * ;

: part-2 ( seq -- n )
    tally [
        [ values supremum ] keep [ value-at ] keepd 2array
    ] assoc-map [
        values [ values supremum ] keep [ value-at dup ] keepd
        2array
    ] keep value-at * ;
