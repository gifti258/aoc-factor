USING: aoc.input arrays assocs assocs.extras grouping kernel
math math.combinatorics math.order math.parser math.statistics
math.vectors multiline peg.ebnf sequences sequences.extras sets
splitting ;
IN: 2021.19

! Beacon Scanner
! part 1: number of beacons
! part 2: largest distance between any two scanners

<<
EBNF: parse [=[
    number = [0-9-]+ => [[ dec> ]]
    rule = number ","~ number ","~ number
]=]

: input ( -- seq )
    input-lines { "" } split [ rest [ parse >array ] map ] map ;
>>

: rotations ( seq -- seq' )
    dup [ first3 swap 3array ] map [
        [ 3 circular-clump ] map flip [
            { 1 -1 } 3 all-selections
            [ [ v* ] curry map ] with map
        ] map-concat
    ] bi@ append ;

: distance/rotation ( seq1 seq2 -- distance/f rotation/f )
    rotations [
        [ [ v- ] with map ] curry map-concat
        histogram [ 12 >= ] filter-values keys ?first
    ] with map-find ;

MEMO: beacons/scanners ( seq -- beacons scanners )
    1 cut f [ over empty? ] [
        pick [
            pick [
                [ distance/rotation ] keep overd over '[
                    [ _ [ _ v+ ] map suffix ]
                    [ _ swap remove ]
                    [ _ suffix ] tri*
                ] when
            ] with each
        ] each
    ] until nip [ concat members ] dip ;

: part-1 ( seq -- n ) beacons/scanners drop length ;

: part-2 ( seq -- n )
    beacons/scanners nip
    2 0 [ first2 v- [ abs ] map-sum max ] reduce-combinations ;
