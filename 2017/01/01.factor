USING: grouping kernel math sequences sequences.extras ;
IN: 2017.01

! Inverse Captcha
! Prove you are not human to escape containment
! part 1: sum consecutive equal digits
! part 2: sum equal digits half a string away

: part-1 ( str -- n )
    2 circular-clump
    [ first2 = ] [ first CHAR: 0 - ] filter-map sum ;

: part-2 ( str -- n )
    halves [ [ = ] keep and ] { } 2map-as sift
    [ CHAR: 0 - ] map-sum 2 * ;
