using: grouping kernel math sequences sequences.extras ;
in: 2017.01

! Inverse Captcha
! Prove you are not human to escape containment
! part 1: sum consecutive equal digits
! part 2: sum equal digits half a string away

: part-1 ( str -- n )
    2 circular-clump
    [ first2 = ] [ first char: 0 - ] filter-map sum ;

: part-2 ( str -- n )
    halves [ [ = ] keep and ] { } 2map-as sift
    [ char: 0 - ] map-sum 2 * ;
