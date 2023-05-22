USING: combinators kernel math math.parser sequences
sequences.extras sets ;
IN: 2020.18

! Operation Order
! part 1: evaluate expressions left to right
! part 2: + has precedence over *

: (eval) ( stack str n -- stack' str )
    pick dup empty? [ push ] [
        dup pop {
            { CHAR: + [ [ pop + ] [ push ] bi ] }
            { CHAR: * [ [ pop * ] [ push ] bi ] }
            { CHAR: ( [ CHAR: ( over push push ] }
        } case
    ] if ;

: eval ( str -- n )
    [ V{ } clone ] dip [
        unclip {
            { [ dup "(+*" in? ] [ pick push ] }
            { [ dup CHAR: ) = ] [
                drop over [ pop ] [ pop* ] bi (eval)
            ] }
            { [ dup CHAR: \s = ] [ drop ] }
            [ digit> (eval) ]
        } cond
    ] until-empty first ;

: part-1 ( seq -- n ) [ eval ] map-sum ;
