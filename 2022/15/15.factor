using: arrays assocs assocs.extras hash-sets kernel math
math.order math.parser math.vectors multiline peg.ebnf ranges
sequences sequences.extras sets ;
in: 2022.15

! Beacon Exclusion Zone
! part 1: number of positions on row 2,000,000 that cannot
! contain beacons
! part 2: get position of distress signal beacon

ebnf: parse [=[
    n = [-0-9]+ => [[ dec> ]]
    pos = " at x="~ n ", y="~ n
    sensor = "Sensor"~ pos ": closest beacon is"~ pos
]=]

constant: line 2,000,000

: (part-1) ( scanner -- set/f )
    [ first first2 ] [ first2 v- l1-norm ] bi swap line
    3dup spin [ - ] [ + ] 2bi between? [
        - abs - [ - ] [ + ] 2bi [a..b] >hash-set
    ] [ 4drop f ] if ;

: part-1 ( seq -- n )
    [ [ (part-1) ] map-sift union-all ]
    [ values [ line = ] filter-values keys diff cardinality ] bi
    ;

constant: max-coordinate 4,000,000

: ring ( scanner -- set )
    [ v{ } clone ] dip
    [ first2 v- l1-norm 1 + [ dup neg [a..b] ] keep ]
    [ first ] bi '[
        dup abs _ - 2dup neg [
            2array _ v+
            dup [ 0 max-coordinate between? ] all?
            [ suffix! ] [ drop ] if
        ] 2bi@
    ] each ;

: in-range? ( pos scanner -- ? )
    first2 dupd [ v- l1-norm ] 2bi@ <= ;

: part-2 ( seq -- n )
    dup '[
        ring [ _ [ in-range? ] with none? ] find nip
    ] map-find drop { 4,000,000 1 } v* sum ;
