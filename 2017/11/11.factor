USING: assocs kernel math math.vectors sequences
sequences.extras splitting ;
IN: 2017.11

! Hex Ed
! Hexagonal grid distance, total and maximum

: parse ( str -- seq )
    "," split [ {
        { "n" { 1 0 } } { "ne" { 0 1 } } { "se" { -1 1 } }
        { "s" { -1 0 } } { "sw" { 0 -1 } } { "nw" { 1 -1 } }
    } at ] map ;

: distance ( v -- n )
    dup [ neg? ] count 1 = [
        [ abs ] map [ infimum ] [ first2 - abs ] bi +
    ] [ sum abs ] if ;

: part-1 ( seq -- n ) [ ] [ v+ ] map-reduce distance ;

: part-2 ( seq -- n )
    { 0 0 } [ v+ ] accumulate* [ distance ] map-supremum ;
