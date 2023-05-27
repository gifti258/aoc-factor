USING: kernel math multiline sequences ;
IN: 2020.25

! Combo Breaker
! Find loop size and encryption key

: (transform) ( n subject-number -- n' ) * 20201227 mod ;

: transform ( loop-size subject-number -- encryption-key )
    [ 1 (( n )) ] 2dip [ (transform) ] curry times ;

: inverse-transform ( public-key subject-number -- loop-size )
    [ 0 1 (( loop-size n )) ] 2dip
    [ over = ] [ (transform) [ 1 + ] dip ] bi-curry* until
    drop ;

: part-1 ( public-keys -- encryption-key )
    first2 [ 7 inverse-transform ] [ transform ] bi* ;
