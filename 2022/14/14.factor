using: arrays assocs combinators generalizations grouping kernel
math math.parser math.vectors multiline peg.ebnf ranges
sequences sets ;
in: 2022.14

! Regolith Reservoir
! part 1: count units of sand that come to rest
! part 2: count units of sand until sand source is blocked

ebnf: parse [=[
    n = [0-9]+ => [[ dec> ]]
    pair = n ","~ n
    line = (pair (" -> "?)~)+
]=]

: parse* ( seq -- pairs )
    [ hs{ } clone ] dip [
        2 <clumps> [
            first2 [ first2 ] bi@ swapd [ [a..b] ] 2bi@
            2dup max-length dup '[
                dup length _ = [ first _ swap <array> ] unless
            ] bi@ [ 2array over adjoin ] 2each
        ] each
    ] each ;

macro: (sand) ( quot -- quot )
    dup dup '[ {
        { [ dup dup @ not ] [ nip t ] }
        { [ drop dup { 1 0 } v- dup @ not ] [ nip t ] }
        { [ drop dup { 1 0 } v+ dup @ not ] [ nip t ] }
        [ drop { 0 1 } v- f ]
    } cond ] ;

: sand ( pairs ymax -- settled? )
    { 500 0 } f [
        drop { 0 1 } v+ dup second pick <= [ [
            [ 5 npick in? ] (sand)
        ] [ f ] if ] keep swap
    ] loop [ [ nip swap adjoin ] [ 3drop ] if ] keep ;

: sand* ( pairs ymax -- not-blocked? )
    { 500 0 } [
        { 0 1 } v+ dup second pick <= [ [
            [ 5 npick in? ] [ second 5 npick = ] bi or
        ] (sand) ] [ f ] if
    ] loop [ nip swap adjoin ] [ { 500 0 } = not ] bi ;

macro: (part) ( quot quot -- quot )
    '[ dup clone dup members values supremum @ [
        2dup @
    ] loop drop swap diff cardinality ] ;

: part-1 ( pairs -- n ) [ ] [ sand ] (part) ;

: part-2 ( pairs -- n ) [ 2 + ] [ sand* ] (part) ;
