USING: assocs assocs.extras kernel math math.combinatorics
math.statistics sequences sequences.extras ;
IN: 2018.02

! Inventory Management System
! part 1: get inventory list checksum
! part 2: get common characters in box IDs differing by only one
! character

: part-1 ( seq -- n )
    2 3 [ '[
        histogram [ _ = ] any-value?
    ] count ] bi-curry@ bi * ;

: part-2 ( seq -- str )
    2 [ first2 [ = not ] 2count 1 = ] find-combination
    first2 zip [ first2 = ] [ first ] "" filter-map-as ;
