USING: accessors generalizations kernel math math.combinatorics
math.parser multiline peg.ebnf ranges sequences sequences.extras
;
IN: 2021.18

! Snailfish
! part 1: magnitude of sum of snailfish numbers
! part 2: largest magnitude of any two snailfish numbers

TUPLE: n n d ;
C: <n> n

EBNF: (parse) [=[
    number = [0-9]+ => [[ dec> ]]
    pair = "["~ (number|pair) ","~ (number|pair) "]"~
]=]

: tree>stack ( tree depth -- stack )
    [ V{ } clone ] 2dip '[
        _ over number? [
            <n> over push
        ] [
            1 + tree>stack over push-all
        ] if
    ] each ;

: parse ( seq -- seq ) (parse) 0 tree>stack ;

: ?add-to-last ( n stack -- )
    [ drop ] [ [ [ + ] change-n ] change-last ] if-empty ;

: explode ( stack -- stack' )
    [ V{ } clone ] dip reverse [
        dup pop dup d>> 4 = [
            n>> pick ?add-to-last
            dup [ pop n>> ] keep ?add-to-last
            0 3 <n>
        ] when pick push
    ] until-empty ;

: split ( stack -- stack' )
    clone dup [ n>> 10 >= ] find swap [
        [
            [ n>> [ 1 + ] keep [ 2/ ] bi@ ]
            [ d>> 1 + tuck ] bi [ <n> ] 2bi@
        ] [ dup 5 npick remove-nth! ] bi*
        [ insert-nth! ] 2curry bi@
    ] [ drop ] if* ;

: reduce* ( stack -- stack' )
    [ dup explode split tuck = not ] loop ;

: (magnitude) ( stack d -- stack' )
    [ V{ } clone ] [ reverse ] [ dup ] tri* '[
        dup pop dup d>> _ = [
            n>> 3 * over pop n>> 2 * + _ 1 - <n>
        ] when pick push
    ] until-empty ;

: magnitude ( stack -- n )
    4 0 [a..b] [ (magnitude) ] each first n>> ;

: add ( a b -- c )
    append [ clone [ 1 + ] change-d ] map reduce* ;

: part-1 ( seq -- n ) [ ] [ add ] map-reduce magnitude ;

: part-2 ( seq -- n )
    2 <k-permutations> [ first2 add magnitude ] map-supremum ;
