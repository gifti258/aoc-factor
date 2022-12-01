USING: accessors arrays aoc.input kernel math math.order
math.parser sets sequences sequences.extras splitting ;
IN: 2016.20

! Firewall Rules
! part 1: find lowest allowed IP
! part 2: count allowed IPs

TUPLE: ip-range a b ;
INSTANCE: ip-range set
: <ip-range> ( a b -- r )
    2dup <= [ ip-range boa ] [ 2drop f ] if ;
: (intersect) ( r1 r2 -- a b )
    [ [ a>> ] bi@ max ] [ [ b>> ] bi@ min ] 2bi ;
M: ip-range intersects? ( r1 r2 -- ? ) (intersect) < ;
: ab ( r -- a b ) [ a>> ] [ b>> ] bi ;
M: ip-range diff ( r1 r2 -- s )
    2dup intersects? [
        [ [ ab ] keep ] dip (intersect) rot
        [ 1 - <ip-range> ] [ [ 1 + ] dip <ip-range> ] 2bi*
        2array sift
    ] [ drop 1array ] if ;
M: ip-range cardinality ( r -- n ) ab swap - 1 + ;

TUPLE: ip-range-set seq ;
INSTANCE: ip-range-set set
: <ip-range-set> ( a b -- s )
    <ip-range> 1array ip-range-set boa ;
M: ip-range-set diff ( s1 s2 -- s )
    [ seq>> ] bi@ first [ diff ] curry map-concat
    ip-range-set boa ;

<< : (input) ( -- seq ) input-lines ; >>

: input ( -- ranges )
    (input) [ "-" split1 [ dec> ] bi@ <ip-range-set> ] map ;

: <full-ip-range> ( -- s ) 0 4294967295 <ip-range-set> ;

: <allowed-ip-ranges> ( -- s )
    <full-ip-range> input [ diff ] each seq>> ;

: part-1 ( -- n ) <allowed-ip-ranges> first a>> ;

: part-2 ( -- n ) <allowed-ip-ranges> [ cardinality ] map-sum ;
