using: accessors arrays kernel math math.order math.parser sets
sequences sequences.extras slots.syntax splitting ;
in: 2016.20

! Firewall Rules
! part 1: find lowest allowed IP
! part 2: count allowed IPs

tuple: ip-range a b ;
instance: ip-range set
: <ip-range> ( a b -- r )
    2dup <= [ ip-range boa ] [ 2drop f ] if ;
: (intersect) ( r1 r2 -- a b )
    [ [ a>> ] bi@ max ] [ [ b>> ] bi@ min ] 2bi ;
m: ip-range intersects? ( r1 r2 -- ? ) (intersect) < ;
m: ip-range diff ( r1 r2 -- s )
    2dup intersects? [
        [ [ get[ a b ] ] keep ] dip (intersect) rot
        [ 1 - <ip-range> ] [ [ 1 + ] dip <ip-range> ] 2bi*
        2array sift
    ] [ drop 1array ] if ;
m: ip-range cardinality ( r -- n ) get[ b a ] - 1 + ;

tuple: ip-range-set seq ;
instance: ip-range-set set
: <ip-range-set> ( a b -- s )
    <ip-range> 1array ip-range-set boa ;
m: ip-range-set diff ( s1 s2 -- s )
    [ seq>> ] bi@ first [ diff ] curry map-concat
    ip-range-set boa ;

: parse ( seq -- seq )
    [ "-" split1 [ dec> ] bi@ <ip-range-set> ] map ;

: <full-ip-range> ( -- set ) 0 4294967295 <ip-range-set> ;

: <allowed-ip-ranges> ( seq -- set )
    [ <full-ip-range> ] dip [ diff ] each seq>> ;

: part-1 ( seq -- n ) <allowed-ip-ranges> first a>> ;

: part-2 ( seq -- n )
    <allowed-ip-ranges> [ cardinality ] map-sum ;
