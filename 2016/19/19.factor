using: kernel math math.functions ;
in: 2016.19

! An Elephant Named Joseph
! Find 1-based Josephus number
! part 2: presents are now stolen from across the circle

: part-1 ( n -- n ) dup log2 2^ - 2 * 1 + ;

: part-2 ( n -- n ) dup 3 logn 1 /i 3 swap ^ - ;
