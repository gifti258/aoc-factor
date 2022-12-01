USING: arrays combinators.extras combinators.short-circuit
grouping kernel math math.vectors sequences sequences.extras
sets splitting ;
IN: 2015.11

! Corporate Policy
! Find the next valid passwords

: next-password ( str -- str )
    [ [ 1 + ] change-last ] keep reverse
    0 [ swap CHAR: z > [ 1 + ] when ] accumulate* reverse
    "{" "a" replace ;

: valid? ( str -- ? )
    {
        [ 3 clump [ >array dup first v-n { 0 1 2 } = ] any? ]
        [ [ "iol" member? ] none? ]
        [ 2 clump [ first2 = ] filter members length 2 >= ]
    } 1&& ;

MEMO: part-1 ( str -- str' )
    [ dup valid? ] [ next-password ] do until ;

: part-2 ( str -- str' ) [ part-1 ] twice ;
