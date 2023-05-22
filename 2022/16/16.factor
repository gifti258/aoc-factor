USING: accessors arrays assocs assocs.extras grouping
grouping.extras hashtables kernel math math.combinatorics
math.order math.parser multiline path-finding peg.ebnf sequences
sequences.extras sets strings ;
IN: 2022.16

! Proboscidea Volcanium
! Maximum amount of pressure that can be relieved in 30 minutes
! part 2: … in 26 minutes with the help of one elephant

TUPLE: valve pressure tunnels ;

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    valve = [A-Z]+ => [[ >string ]]
    line = "Valve "~ valve " has flow rate="~ n
        "; tunnel"~ ("s"?)~ " lead"~ ("s"?)~ " to valve"~
        ("s"?)~ " "~ (valve (", "?)~)+
        => [[ first3 valve boa 2array ]]
]=]

TUPLE: tunnels < astar valves ;
M: tunnels neighbors valves>> at tunnels>> ;
M: tunnels cost 3drop 1 ;
M: tunnels heuristic 3drop 1 ;
: <tunnels> ( assoc -- astar ) [ tunnels new ] dip >>valves ;

MACRO: (relief) ( n -- quot: ( path paths assoc -- n ) )
    '[ [ 2 clump ] 2dip '[
        [ _ at ] [ second _ at pressure>> suffix ] bi
    ] map-concat "AA" prefix <prefixes> [
        [ number? ] filter sum
    ] map _ over length - over last <array> append sum ] ;

: relief ( path paths assoc -- n ) 30 (relief) ;

: relief* ( path paths assoc -- n ) 26 (relief) ;

:: (most-relief) ( path assoc voi paths n
    most-relief-quot: ( path assoc voi paths -- n )
    relief-quot: ( path paths assoc -- n )
    quot: ( n voi path assoc cache paths -- n' )
    -- n )
    voi path diff [
        path swap suffix :> path
        path 2 clump [
            [ paths at length ] map-sum
        ] [ length ] bi + n < [
            path assoc voi paths most-relief-quot call
            path paths assoc relief-quot call
            voi path diff { "AA" } assoc H{ } paths quot call
            max
        ] [ 0 ] if
    ] map ?supremum 0 or ; inline recursive

: most-relief ( path assoc voi paths -- n )
    30 [ most-relief ] [ relief ] [ 5drop ] (most-relief) ;

: (most-relief*) ( path assoc voi paths -- n )
    26 [ (most-relief*) ] [ relief* ] [ 5drop ] (most-relief) ;

: most-relief* ( path assoc voi paths -- n )
    26 [ most-relief* ] [ relief* ] [
        [ (most-relief*) ] curry 2with cache +
    ] (most-relief) ;

MACRO: (part) ( quot -- quot: ( assoc -- n ) )
    '[ { "AA" } swap >hashtable [
        dup [ pressure>> 0 > ] filter-values keys "AA" prefix
        dup 2
    ] [ '[
        dup first2 _ <tunnels> find-path rest 2array
    ] map-selections >hashtable @ ] bi ] ;

: part-1 ( assoc -- n ) [ most-relief ] (part) ;

: part-2 ( assoc -- n ) [ most-relief* ] (part) ;
