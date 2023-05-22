USING: arrays assocs kernel math math.matrices math.parser
math.statistics math.vectors multiline peg.ebnf ranges sets
sequences ;
IN: 2018.06

! Chronal Coordinates
! part 1: size of largest finite area
! part 2: size of region with total distance to all points <=
! 10,000

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    rule = n ", "~ n
]=]

: distance-matrix-map ( seq quot -- m )
    [ dup flip [ minmax [a..b] ] map first2 cartesian-product ]
    [ [
        swap [ v- l1-norm ] with map
    ] prepose with matrix-map ] bi* ; inline

: part-1 ( seq -- n )
    [
        [ infimum ] keep indices [ length 1 = ] [ first ] bi and
    ] distance-matrix-map [ concat ] [
        dup flip [
            [ first ] [ last ] bi
        ] bi@ 4array concat members
    ] bi without histogram values supremum ;

: part-2 ( seq n -- n )
    '[ sum _ < ] distance-matrix-map concat sift length ;
