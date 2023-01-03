using: combinators.extras generalizations kernel math math.order
math.parser math.vectors multiline peg.ebnf ranges sequences ;
in: 2021.21

! Dirac Dice
! part 1: product of losing score and number of die rolls
! part 2: number of universes the most winning player wins in

ebnf: parse [=[
    n = [0-9]+ => [[ dec> ]]
    line = "Player "~ n~ " starting position: "~ n
]=]

: roll ( start -- end move )
    [ dup 100 mod 1 + ] thrice [ + ] [ + ] [ swap ] tri* ;

: pos ( pos move -- pos' ) + 1 - 10 mod 1 + ;

:: part-1 ( poss -- n )
    poss first2 0 0 0 :> ( pos1! pos2! score1! score2! rolls! )
    1 [
        roll rolls 3 + rolls!
        pos1 pos pos1!
        score1 pos1 + score1!
        score1 1000 >= [ f ] [
            roll rolls 3 + rolls!
            pos2 pos pos2!
            score2 pos2 + score2!
            score2 1000 >= not
        ] if
    ] loop drop score1 score2 min rolls * ;

defer: dirac
memo: turn ( score pos v die-sum -- v )
    [ [ [ v* supremum ] [ pos ] bi* ] keepd n*v ] 2keepd
    [ reverse v* [ [ v+ ] keep ] [ v+ ] bi* ] keep
    pick over v* supremum 21 >= [ 2nip ] [ dirac ] if ;

memo: dirac ( score pos v -- v )
    reverse 3 9 [a..b] [ turn ] 3 nwith map
    { 1 3 6 7 6 3 1 } [ v*n ] 2map [ ] [ v+ ] map-reduce ;

: part-2 ( poss -- n ) { 0 0 } swap { 0 1 } dirac supremum ;
