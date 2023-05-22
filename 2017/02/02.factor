USING: kernel math math.combinatorics sequences ;
IN: 2017.02

! Corruption Checksum
! Help repair corruption in the spreadsheet by calculating the
! checksum
! part 1: line checksum is the difference between highest and
! lowest element
! part 2: line checksum is the quotient of the two evenly
! divisible numbers

: part-1 ( seq -- n )
    [ [ supremum ] [ infimum ] bi - ] map-sum ;

: part-2 ( seq -- n )
    [
        2 <k-permutations> [
            first2 /mod zero? swap and
        ] map-find drop
    ] map-sum ;
