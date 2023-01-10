using: combinators kernel math math.parser sequences
sequences.extras sets ;
in: 2020.18

! Operation Order
! part 1: evaluate expressions left to right
! part 2: + has precedence over *

: (eval) ( stack str n -- stack' str )
    pick dup empty? [ push ] [
        dup pop {
            { char: + [ [ pop + ] [ push ] bi ] }
            { char: * [ [ pop * ] [ push ] bi ] }
            { char: ( [ char: ( over push push ] }
        } case
    ] if ;

: eval ( str -- n )
    [ v{ } clone ] dip [
        unclip {
            { [ dup "(+*" in? ] [ pick push ] }
            { [ dup char: ) = ] [
                drop over [ pop ] [ pop* ] bi (eval)
            ] }
            { [ dup char: \s = ] [ drop ] }
            [ digit> (eval) ]
        } cond
    ] until-empty first ;

: part-1 ( seq -- n ) [ eval ] map-sum ;
