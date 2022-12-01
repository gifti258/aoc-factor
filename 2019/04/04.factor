USING: aoc.input assocs grouping kernel math math.parser
math.statistics ranges sequences splitting ;
IN: 2019.04

! Secure Container
! Count number of possible passwords

<< : input ( -- seq ) input-line "-" split [ dec> ] map ; >>

: possible? ( n -- ? )
    [ [ <= ] monotonic? ]
    [ 2 clump [ first2 = ] any? ] bi and ;

: possible?* ( n -- ? )
    [ possible? ]
    [ histogram values 2 swap member? ] bi and ;

:: count-passwords ( seq quot -- n )
    seq first2 [a..b] [ >dec ] quot compose count ; inline

: part-1 ( seq -- n ) [ possible? ] count-passwords ;

: part-2 ( seq -- n ) [ possible?* ] count-passwords ;
