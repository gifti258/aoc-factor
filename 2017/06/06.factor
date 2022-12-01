USING: kernel math ranges sequences sequences.extras ;
IN: 2017.06

! Memory Reallocation
! Redistribute memory banks until configurations repeat
! part 1: number of redistributions until first repeat
! part 2: cycle length

: redistribute ( seq -- seq' )
    clone [ supremum ] [ arg-max ] [ 0 2over set-nth ] tri
    spin [1..b] [
        + over length mod over [ 1 + ] change-nth
    ] with each ;

: reallocate ( seq -- seqs seq' )
    V{ } clone swap [
        2dup swap member?
    ] [
        [ over push ] keep redistribute
    ] until ;

: part-1 ( seq -- n ) reallocate drop length ;

: part-2 ( seq -- n )
    reallocate [ drop length ] [ swap index ] 2bi - ;
