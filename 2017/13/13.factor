using: aoc.input kernel math math.parser multiline peg.ebnf
sequences ;
in: 2017.13

! Packet Scanners
! part 1: calculate trip severity
! part 2: find shortest delay to pass firewall

ebnf: parse [=[
    n = [0-9]+ => [[ dec> ]]
    layer = n ": "~ n
]=]

: severity ( n -- n )
    $[ input-lines ] [
        parse first2 2dup [ roll + ] [ 2 * 2 - ] bi* mod
        zero? [ * ] [ 2drop 0 ] if
    ] with map-sum ;

: part-1 ( -- n ) 0 severity ;
