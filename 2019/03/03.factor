using: assocs kernel math math.parser math.vectors
multiline peg.ebnf sequences sets ;
in: 2019.03

! Crossed Wires
! Find the nearest intersection of two wires to origin

ebnf: parse [=[
    turn = ("D"|"L"|"R"|"U")
    length = ([0-9])+ => [[ dec> ]]
    direction = turn length (","?)~
    rule = (direction)+
]=]

: points ( seq -- seq )
    { 0 0 } swap [
        first2
        [ {
            { "R" { 1 0 } } { "L" { -1 0 } }
            { "U" { 0 1 } } { "D" { 0 -1 } }
        } at ] dip
        [ v+ dup ] with replicate
    ] map nip concat ;

: part-1 ( seq -- n )
    [ points ] map intersect-all [ l1-norm ] map infimum ;

: part-2 ( seq -- n )
    [ points ] map dup intersect-all
    [ [ swap index 1 + ] curry map-sum ] with map infimum ;
