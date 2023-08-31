USING: assocs assocs.extras kernel math math.parser multiline
peg.ebnf ;
IN: 2017.13

! Packet Scanners
! part 1: calculate trip severity
! part 2: find shortest delay to pass firewall

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    layer = n ": "~ n
]=]

: caught? ( depth range -- ? ) 2 * 2 - mod zero? ;

: part-1 ( assoc -- n )
    0 [ 2dup caught? [ * ] [ 2drop 0 ] if + ] assoc-reduce ;

: pass? ( assoc delay -- ? )
    '[ [ _ + ] dip caught? ] assoc-find 2nip ;

: part-2 ( assoc -- n )
    0 swap '[ _ over pass? ] [ 1 + ] while ;
