using: aoc.input kernel literals math math.combinatorics
math.parser math.vectors ranges sequences ;
in: 2018.11

! Chronal Charge
! Find square with the highest power

memo: power-level ( loc -- n )
    first2 [ 10 + ] dip over * $[ input-n ] + * 1000 mod 100 /i
    5 - ;

: square-sum ( loc n -- n )
    <iota> 2 all-selections [ v+ power-level ] with map-sum ;

: format ( seq -- str ) [ >dec ] map "," join ;

: part-1 ( -- str )
    1 298 [a..b] 2 all-selections
    [ 3 square-sum ] supremum-by format ;
