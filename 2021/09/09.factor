USING: aoc.groups aoc.matrices kernel math math.vectors
sequences ;
IN: 2021.09

! Smoke basin
! part 1: risk level sum of map minima
! part 2: size product of 3 largest basins

: part-1 ( m -- n )
    dup cardinal-neighbor-infimum
    [ dupd < [ 1 + ] [ drop 0 ] if ] matrix-2map-sum ;

: part-2 ( m -- n )
    [ 9 < ] matrix>pairs [ v- l1-norm 1 = ] group-sizes
    3 tail* product ;
