USING: aoc.groups aoc.input aoc.matrices arrays assocs kernel
math math.constants math.functions math.matrices.extras
math.vectors sequences sequences.extras sorting ;
IN: 2019.10

! Monitoring Station
! part 1: find asteroid with mosts asteroids in direct line of
! sight
! part 2: find 200th asteroid vaporized

<< : input ( -- seq ) input-matrix [ 1 = ] matrix>pairs ; >>

: same-line? ( p1 p2 -- ? )
    [ [ [ sgn ] same? ] 2all? ]
    [ 2array determinant 0 = ] 2bi and ;

MEMO: (part-1) ( seq -- seqs ns )
    dup '[ [ _ remove ] keep '[ _ v- ] map ] map
    dup [ [ same-line? ] count-groups ] map ;

: part-1 ( seq -- n ) (part-1) nip supremum ;

: pos>polar ( pos -- angle/distance )
    first2 swap rect> >polar pi / 1/2 + 2 rem swap 2array ;

: part-2 ( seq -- n )
    dup (part-1) arg-max '[ _ swap nth ] bi@
    [ [ v+ ] keep pos>polar 2array ] with map
    [ second ] sort-with [ second first ] collect-by
    sort-keys values [ keys ] map round-robin
    199 swap nth first2 100 * + ;
