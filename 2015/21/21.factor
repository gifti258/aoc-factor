USING: accessors aoc.input arrays kernel math math.combinatorics
math.parser multiline peg.ebnf sequences sequences.deep
sequences.extras sets ;
IN: 2015.21

! RPG Simulator 20XX
! Turn-based RPG simulation
! part 1: least amount of gold to still win the fight
! part 2: most amount of gold to still lose the fight

TUPLE: player hitpoints damage armor ;
TUPLE: item cost damage armor ;

CONSTANT: weapons {
    T{ item f 8 4 0 } T{ item f 10 5 0 } T{ item f 25 6 0 }
    T{ item f 40 7 0 } T{ item f 74 8 0 }
}

CONSTANT: armor {
    T{ item f 0 0 0 } T{ item f 13 0 1 } T{ item f 31 0 2 }
    T{ item f 53 0 3 } T{ item f 75 0 4 } T{ item f 102 0 5 }
}

CONSTANT: rings {
    T{ item f 0 0 0 } T{ item f 0 0 0 } T{ item f 25 1 0 }
    T{ item f 50 2 0 } T{ item f 100 3 0 } T{ item f 20 0 1 }
    T{ item f 40 0 2 } T{ item f 80 0 3 }
}

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    line = ([A-Za-z: ]+)~ n
]=]

<< : (input) ( -- seq ) input-parse ; >>

: input ( -- boss ) (input) first3 player boa ;

:: win? ( player boss -- ? )
    [
        boss hitpoints>> player damage>> boss armor>> - -
        dup boss hitpoints<< 0 > [
            player hitpoints>> boss damage>> player armor>> - -
            dup player hitpoints<< 0 >
        ] [ f ] if
    ] loop player hitpoints>> 0 > ;

: amounts ( boss quot -- seq )
    [ weapons ] 2dip '[ armor [
        rings 2 all-combinations members [
            [ 2dup ] dip first2 4array
            [ cost>> ] [ damage>> ] [ armor>> ]
            [ map-sum ] tri-curry@ tri
            T{ player f 100 0 0 } clone
            swap >>armor swap >>damage
            _ clone win? @ swap and
        ] map-sift nip
    ] map nip ] map flatten ; inline

: part-1 ( boss -- n ) [ ] amounts infimum ;

: part-2 ( boss -- n ) [ not ] amounts supremum ;
