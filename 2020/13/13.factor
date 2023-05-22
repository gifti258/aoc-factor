USING: aoc.input assocs kernel math math.algebra math.parser
sequences splitting ;
IN: 2020.13

! Shuttle Search
! part 1: product of earliest bus ID and waiting time
! part 2: earliest timestamp for all busses to depart at
! matching offsets

: parse ( seq -- n seq )
    first2 [ dec> ] [ csn-line ] bi* ;

: part-1 ( n seq -- n )
    [ neg ] dip sift [ [ rem ] keep ] with map>alist
    [ first ] infimum-by product ;

: part-2 ( n seq -- n )
    nip zip-index sift-keys unzip
    [ [ [ - ] keepd rem ] 2map ] keepd chinese-remainder ;
