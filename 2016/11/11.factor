USING: aoc.matrices arrays assocs assocs.extras kernel math
math.combinatorics math.order math.matrices math.vectors
multiline path-finding peg.ebnf sequences sequences.extras
sequences.product sets sorting strings ;
IN: 2016.11

! Radioisotope Thermoelectric Generators
! Bring the generators and microchips to the fourth floor in the
! fewest amount of steps possible

SYMBOLS: +g+ +m+ ;

EBNF: parse [=[
    str = [a-z]+ => [[ >string ]]
    generator = " generator" => [[ +g+ ]]
    microchip = "-compatible microchip" => [[ +m+ ]]
    empty = "nothing relevant" => [[ f ]]
    item = "a "~ str (generator|microchip)
    items = ((item (","?" "~)~)+ ("and "~)?)? (item)
        => [[ first2 suffix ]]
    line = "The "~ str~ " floor contains "~ (empty|items) "."~
]=]

: parse* ( seq -- state' )
    sift zip-index [ ] collect-assoc-by-multi
    [ append 1 cut ] collect-assoc-by values
    [ [ +m+ of ] [ +g+ of ] bi 2array ] map sort
    0 prefix ;

: valid? ( state' -- ? )
    rest unzip [ <enumerated> >array ] bi@ 4 [
        '[ [ _ = ] filter-values ] bi@
        [ diff ] keep [ empty? ] either?
    ] 2with all-integers? ;

TUPLE: elevator < astar ;
M: elevator cost 3drop 1 ;
M: elevator heuristic 3drop 1 ;
M: elevator neighbors ( state' elevator -- seq )
    drop unclip [
        { 1 -1 } n+v over mmin '[ _ 3 between? ] filter
    ] 2keep '[ _ = ] matrix>pairs
    { 1 2 } [ all-combinations ] with map-concat 2array [
        [ [ clone ] map ] dip first2
        [ pick matrix-set-nths ] keepd prefix
    ] with product-map [ valid? ] filter ;

MEMO: part-1 ( state' -- n )
    dup length 1 - { 3 3 } <array> 3 prefix elevator new
    find-path length 1 - ;

: part-2 ( state' -- n ) 2 { 0 0 } <array> append part-1 ;
