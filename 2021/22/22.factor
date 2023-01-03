using: aoc.matrices arrays combinators generalizations grouping
kernel math math.matrices math.order math.parser math.vectors
multiline peg.ebnf sequences sequences.extras
sequences.generalizations sequences.product sets sorting ;
in: 2021.22

! Reactor Reboot
! Count cubes in on state

ebnf: parse [=[
    number = [0-9-]+ => [[ dec> ]]
    range = [x-z]~ "="~ number ".."~ number (","?)~
    rule = ("on"|"off") " "~ range range range
]=]

: cuboids-intersect? ( cuboid1 cuboid2 -- ? )
    [ [ vmax first ] [ vmin second ] 2bi <= ] 2all? ;

: merge ( seq -- pair )
    [ first2 <= ] filter
    [ first first ] [ last second ] bi 2array ;

: cuboid-diff ( cuboid1 cuboid2 -- cuboids )
    [
        [ first ] [ second ] [ bi@ 2array ] bi-curry@ 2bi {
            [ drop infimum ]
            [ [ second 1 - ] [ first min ] bi* ]
            [ [ supremum ] [ infimum dup 1 + ] bi* ]
            [ [ first max ] [ first ] bi* ]
        } 2cleave [ 2array ] 2tri@ 3array
    ] 2map first3 {
        [ [ first ] [ merge ] [ merge ] tri* ]
        [ [ third ] [ merge ] [ merge ] tri* ]
        [ [ second ] [ first ] [ merge ] tri* ]
        [ [ second ] [ third ] [ merge ] tri* ]
        [ [ second ] [ second ] [ first ] tri* ]
        [ [ second ] [ second ] [ third ] tri* ]
    } 3cleave [ 3array ] 3 6 mnapply 6 narray
    [ [ first2 <= ] all? ] filter ;

: reboot ( seq -- n )
    1 cut [ [ rest ] map ] dip [
        unclip [ [
            v{ } clone -rot [
                2dup cuboids-intersect? [
                    cuboid-diff append
                ] [ drop suffix ] if
            ] curry each
        ] keep ] dip "on" = [ suffix ] [ drop ] if
    ] each [ [ first2 swap - 1 + ] map-product ] map-sum ;

: part-1 ( seq -- n )
    [ rest [ [ -50 50 between? ] all? ] all? ] filter reboot ;

: part-2 ( seq -- n ) reboot ;
