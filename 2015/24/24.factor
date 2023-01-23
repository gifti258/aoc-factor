using: kernel math math.combinatorics ranges sequences
sequences.extras sets ;
in: 2015.24

! It Hangs in the Balance
! Find smallest quantum entanglement of balanced packages

: fewest-packages ( seq n k -- seq )
    [ over sum ] dip / '[ sum _ = ] filter-combinations
    [ f ] when-empty ;

: min-entanglement ( seq n -- n )
    [ dup length [1..b] ] dip
    [ '[ dupd _ fewest-packages ] map-find drop ]
    [ '[
        dupd diff dup length [1..b]
        [ dupd _ 1 - fewest-packages ] any? nip
    ] filter ] bi [ product ] map-infimum nip ;

: part-1 ( seq -- n ) 3 min-entanglement ;

: part-2 ( seq -- n ) 4 min-entanglement ;
