USING: combinators kernel math.parser math.statistics ranges
sequences sets ;
IN: 2020.05

! Binary Boarding
! part 1: find highest seat ID on a boarding pass
! part 2: get your own seat ID

: map-seat-ids ( seq -- seq' )
    [ [ {
        { CHAR: F [ CHAR: 0 ] }
        { CHAR: B [ CHAR: 1 ] }
        { CHAR: L [ CHAR: 0 ] }
        { CHAR: R [ CHAR: 1 ] }
    } case ] map bin> ] map ;

: part-1 ( seq -- n ) map-seat-ids supremum ;

: part-2 ( seq -- n )
    map-seat-ids [ minmax [a..b] ] keep diff first ;
