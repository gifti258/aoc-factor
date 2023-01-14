using: kernel math.combinatorics sequences sets sorting ;
in: 2017.04

! High-Entropy Passphrases
! Count valid passwords

: part-1 ( seq -- n )
    [ [ length ] [ cardinality ] bi = ] count ;

: part-2 ( seq -- n )
    [ 2 [ first2 [ natural-sort ] same? ] find-combination not ]
    count ;
