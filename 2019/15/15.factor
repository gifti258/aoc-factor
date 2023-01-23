using: 2019.intcode accessors aoc.matrices arrays assocs deques
dlists kernel math path-finding ranges sequences
sequences.extras sets ;
in: 2019.15

! Oxygen System
! part 1: fewest movement commands to oxygen system
! part 2: minutes until area is filled

symbol: +goal+

:: (neighbors) ( node -- seq )
    node first2 :> ( pos state )
    pos cardinal-coordinate-neighbors 4 [1..b] [
        :> ( pos' command )
        state clone [ clone ] change-memory :> state'
        state' command 1dlist >>inputs <dlist> >>outputs
        run-until-output outputs>> pop-back :> status
        { status pos' state' }
    ] 2map [ first 0 = not ] filter ;

tuple: oxygen < astar final ;
m: oxygen neighbors ( node astar -- seq )
    [ (neighbors) ] dip '[
        unclip 2 = [ _ final<< +goal+ ] when
    ] map ;
m: oxygen heuristic ( from to astar -- n ) 3drop 1 ;
m: oxygen cost ( from to astar -- n ) 3drop 1 ;

memo: length/astar ( seq -- length astar )
    intcode-state new swap >>memory { 0 0 } swap 2array
    +goal+ oxygen new [ find-path length 1 - ] [ final>> ] bi ;

: part-1 ( seq -- n ) length/astar drop ;

:: explore ( node visited depth -- )
    depth 1 + :> depth
    node (neighbors) [ rest ] map
    [ first visited keys in? ] reject
    [ depth suffix ] map
    [ visited adjoin-all ]
    [ [ depth suffix ] map [ visited depth explore ] each ] bi ;

: part-2 ( seq -- n )
    length/astar nip v{ } clone over 0 suffix over adjoin
    [ 0 explore ] [ [ third ] map-supremum ] bi ;
