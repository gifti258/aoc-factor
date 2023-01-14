using: aoc.matrices arrays kernel math math.combinatorics
math.matrices sets ;
in: 2015.18

! Like a GIF For Your Yard
! Animate Christmas lights (Conway's Game of Life)
! Count lights turned on
! part 2: … with corner lights always on

: animate ( seq quot -- n )
    100 swap [ '[ @ dup neighbor-sum [
        2array { { 1 2 } { 1 3 } { 0 3 } } in? 1 0 ?
    ] matrix-2map ] times ] keep call matrix-sum ; inline

: part-1 ( m -- n ) [ ] animate ;

: part-2 ( m -- n )
    [
        1 { 0 99 } 2 all-selections pick matrix-set-nths
    ] animate ;
