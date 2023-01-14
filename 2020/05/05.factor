using: combinators kernel math.parser math.statistics ranges
sequences sets ;
in: 2020.05

! Binary Boarding
! part 1: find highest seat ID on a boarding pass
! part 2: get your own seat ID

: map-seat-ids ( seq -- seq' )
    [ [ {
        { char: F [ char: 0 ] }
        { char: B [ char: 1 ] }
        { char: L [ char: 0 ] }
        { char: R [ char: 1 ] }
    } case ] map bin> ] map ;

: part-1 ( seq -- n ) map-seat-ids supremum ;

: part-2 ( seq -- n )
    map-seat-ids [ minmax [a..b] ] keep diff first ;
