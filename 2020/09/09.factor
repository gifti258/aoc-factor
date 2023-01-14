using: grouping kernel math math.combinatorics math.statistics
sequences sequences.extras ;
in: 2020.09

! Encoding Error
! part 1: find first number that isn't the sum of 2 of the 25
! number before it
! part 2: find contiguous set of at least 2 numbers that sum to
! number in part 1

: part-1 ( seq -- n )
    26 clump [
        unclip-last 2 [ sum = ] with find-selection not
    ] find nip last ;

: part-2 ( seq -- n )
    [ part-1 ] keep [ sum = ] with filter-all-subseqs last
    minmax + ;
