USING: assocs assocs.extras kernel math math.vectors multiline
peg.ebnf sequences ;
IN: 2020.24

! Lobby Layout
! Number of tiles left with the black side up

EBNF: parse [=[
    tile = ("e"|"se"|"sw"|"w"|"nw"|"ne")+
]=]

: position ( seq -- v )
    [ {
        { "e" { 1 0 } } { "se" { 1 -1 } } { "sw" { 0 -1 } }
        { "w" { -1 0 } } { "nw" { -1 1 } } { "ne" { 0 1 } }
    } at ] [ v+ ] map-reduce ;

: flip ( seq -- seq/assoc? )
    H{ } clone swap
    [ position over inc-at ] each
    [ odd? ] filter-values ;

: part-1 ( seq -- n ) flip assoc-size ;
