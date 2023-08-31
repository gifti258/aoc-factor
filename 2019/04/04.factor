USING: assocs grouping kernel math math.parser math.statistics
ranges sequences splitting sets ;
IN: 2019.04

! Secure Container
! Count number of possible passwords

: parse ( str -- seq ) "-" split [ dec> ] map ;

: possible? ( n -- ? )
    [ [ <= ] monotonic? ]
    [ 2 clump [ first2 = ] any? ] bi and ;

: possible?* ( n -- ? )
    [ possible? ]
    [ histogram values 2 swap in? ] bi and ;

: count-passwords ( seq quot -- n )
    [ first2 [a..b] ] dip '[ >dec @ ] count ; inline

: part-1 ( seq -- n ) [ possible? ] count-passwords ;

: part-2 ( seq -- n ) [ possible?* ] count-passwords ;
