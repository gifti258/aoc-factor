USING: ascii grouping kernel math ranges sequences
sequences.extras splitting ;
IN: 2018.05

! Alchemical Reduction
! part 1: length of fully reacted polymer
! part 2: shortest polymer possible by removing all units of one
! type

: react ( str -- str )
    [ dup 2 clump [ first2 - abs 32 = ] find swap ]
    [ "" replace ] while drop ;

: part-1 ( str -- n ) react length ;

: part-2 ( str -- n )
    CHAR: a CHAR: z [a..b] [
        '[ ch>lower _ = ] reject part-1
    ] with map-infimum ;
