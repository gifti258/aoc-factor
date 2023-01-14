using: grouping kernel math sequences ;
in: 2016.18

! Like a Rogue
! Number of safe tiles

: next-row ( str -- str )
    { f } 1surround 3 clump [ [ first ] [ third ] bi xor ] map ;

: count-safe-tiles ( str n -- n )
    [ 0 ] [ [ char: ^ = ] { } map-as ] [ ] tri*
    [ [ [ not ] count + ] keep next-row ] times drop ;

: part-1 ( str -- n ) 40 count-safe-tiles ;

: part-2 ( str -- n ) 400000 count-safe-tiles ;
