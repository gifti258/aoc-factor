using: aoc.matrices kernel math math.matrices ;
in: 2021.11

! Dumbo Octopus
! part 1: count total flashes after 100 steps
! part 2: first step when all octopuses flash

: step ( n m -- n' m' )
    1 m+n 10 <zero-square-matrix> [
        over [ 9 > 1 0 ? ] matrix-map
        swap [ m- ] [ [ bitor ] matrix-2map ] 2bi
        over 10 <zero-square-matrix> =
    ] [ [ neighbor-sum m+ ] dip ] until nip
    matrix-sum '[ _ + ] dip
    [ dup 9 > [ drop 0 ] when ] matrix-map ;

: part-1 ( m -- n ) 0 swap 100 [ step ] times drop ;

: part-2 ( m -- n )
    [ 0 0 ] dip [ dup 10 <zero-square-matrix> = ]
    [ [ 1 + ] 2dip step ] until 2drop ;
