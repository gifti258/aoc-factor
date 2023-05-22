USING: kernel math.combinatorics sequences sets sorting ;
IN: 2017.04

! High-Entropy Passphrases
! Count valid passwords

: part-1 ( seq -- n )
    [ [ length ] [ cardinality ] bi = ] count ;

: part-2 ( seq -- n )
    [ 2 [ first2 [ sort ] same? ] find-combination not ]
    count ;
