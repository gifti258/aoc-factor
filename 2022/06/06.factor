using: grouping kernel math sequences sets ;
in: 2022.06

! Tuning Trouble
! Find number of characters after which 4/14 different
! characters have been received

: find-marker ( str n -- n )
    [ <clumps> [ all-unique? ] find drop ] [ + ] bi ;

: part-1 ( str -- n ) 4 find-marker ;

: part-2 ( str -- n ) 14 find-marker ;
