using: accessors arrays kernel math math.combinatorics
math.functions math.parser math.vectors multiline peg.ebnf
sequences slots.syntax ;
in: 2019.12

! The N-Body Problem
! part 1: Find total energy after 1000 steps
! part 2: Find cycle length

ebnf: parse [=[
    n = [0-9-]+ => [[ dec> ]]
    pos = "<x="~ n ", y="~ n ", z="~ n ">"~
]=]

tuple: moon s v ;

: parse* ( seq -- seq ) [ >array { 0 0 0 } moon boa ] map ;

: step ( seq -- seq' )
    [ 2 <k-permutations> [
        first2 tuck [ s>> ] bi@ [ - sgn ] 2map
        '[ _ v+ ] change-v drop
    ] each ]
    [ [ [ v>> ] [ [ v+ ] change-s ] bi ] map ] bi ;

: energy ( seq -- n ) [ get[ s v ] [ l1-norm ] bi@ * ] map-sum ;

: part-1 ( seq -- n ) 1000 [ step ] times energy ;

: cycle-length ( seq -- n )
    [ 0 ] dip [ 1array { 0 } moon boa ] map
    dup [ clone ] map '[
        dup _ =
    ] [ step [ 1 + ] dip ] do until drop ;

: part-2 ( seq -- n ) flip [ cycle-length ] [ lcm ] map-reduce ;
