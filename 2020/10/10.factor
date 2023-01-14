using: assocs grouping.extras kernel math.statistics
math.vectors sequences sorting ;
in: 2020.10

! Adapter Array
! part 1: joltage adapter chain: product of number of 3 and 1
! jolt differences
! part 2: count ways to connect charger to outlet

: differences ( seq -- seq' )
    natural-sort dup 0 prefix v- 3 suffix ;

: part-1 ( seq -- n )
    differences histogram values product ;

: part-2 ( seq -- n )
    differences [ 1 = ] group-by sift-keys values
    [ length ] map 1 v-n
    { { 0 1 } { 1 2 } { 2 4 } { 3 7 } } substitute product ;
