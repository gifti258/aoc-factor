USING: aoc.matrices arrays assocs assocs.extras kernel math
sequences sequences.extras splitting ;
IN: 2019.06

! Universal Orbit Map
! part 1: number of direct and indirect orbits
! part 2: minimum number of orbit transfers between objects YOU
! and SAN are orbiting

: parse ( str -- seq ) ")" split ;

: orbits ( seq str -- sum n )
    over
    [ first = ] with [ second orbits 2array ] with filter-map
    [ matrix-sum ] [ sum-values ] bi 1 + ;

: part-1 ( seq -- n ) "COM" orbits drop ;

: find-path ( seq str -- seq )
    over [ second = ] with find nip first dup "COM" =
    rot [ 1array ] [ [ find-path ] keep suffix ] with if ;

: part-2 ( seq -- n )
    "YOU" "SAN" [ find-path ] bi-curry@ bi drop-prefix
    append length ;
