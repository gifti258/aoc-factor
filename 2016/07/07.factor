USING: aoc.input grouping kernel math multiline peg.ebnf ranges
sequences sequences.extras sets strings ;
IN: 2016.07

! Internet Protocol Version 7
! Count how many ip addresses support TLS/SSL

EBNF: parse [=[
    str = [a-z]+ => [[ >string ]]
    ip = (str ("["~ str "]"~)?)+
]=]

<< : input ( -- seq ) input-parse [ flip ] map ; >>

: abba? ( str -- ? )
    dup length 2 - 2 swap [a..b] [
        cut swap reverse
        [ [ 2 head ] same? ]
        [ first2 = not ] bi and
    ] with any? ;

: tls? ( seq -- ? )
    first2 sift
    [ [ abba? ] any? ]
    [ [ abba? ] none? ] bi* and ;

: part-1 ( seq -- n ) [ tls? ] count ;

: abas ( seq -- abas )
    [ 3 clump [ [ first ] [ third ] bi = ] filter ] map-concat ;

: babs ( seq -- babs )
    abas [ { 1 0 1 } swap nths ] map ;

: ssl? ( seq -- ? )
    first2 sift [ abas ] [ babs ] bi* intersects? ;

: part-2 ( seq -- n ) [ ssl? ] count ;
