USING: ascii assocs combinators kernel math
math.parser multiline peg.ebnf sequences strings ;
IN: 2015.07

! Some Assembly Required
! Assemble wires, get output of wire a
! part 2: feed wire b to wire a, reset the other instructions,
! run again

EBNF: parse [=[
    name = [a-z]+ => [[ >string ]]
    number = [0-9]+ => [[ dec> ]]
    signal = name|number
    1gate = ("NOT "~ => [[ "not" ]]) signal
    operator = " "~ ("AND"|"OR"|"LSHIFT"|"RSHIFT") " "~
        => [[ >lower ]]
    2gate = signal:a operator:b signal:c => [[ { b a c }  ]]
    wire = name:w => [[ { "wire" w } ]]
    gate = 1gate|2gate|wire|number
    instruction = gate " -> "~ name
]=]

: part-1 ( seq -- n )
    [ [ first number? ] partition "a" pick value-at dup ] [
        drop swap '[
            unclip unclip [ [ [ _ value-at ] keep or ] map ] dip
            over [ number? ] all? [ {
                { "not" [ first bitnot ] }
                { "and" [ first2 bitand ] }
                { "or" [ first2 bitor ] }
                { "lshift" [ first2 shift ] }
                { "rshift" [ first2 neg shift ] }
                { "wire" [ first ] }
            } case ] [ prefix ] if prefix
        ] map
    ] until 2nip ;

: part-2 ( seq -- n )
    dup part-1 '[ dup "b" = [ nip _ swap ] when ] assoc-map
    part-1 ;
