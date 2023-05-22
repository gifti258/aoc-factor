USING: arrays assocs assocs.extras combinators.extras grouping
kernel math math.combinatorics math.matrices multiline peg.ebnf
sequences ;
IN: 2017.21

! Fractal Art
! Count pixels which are on after 5/18 enhancements

EBNF: parse [=[
    line = [.#]+ => [[ >array ]]
    square = (line ("/"?)~)+ => [[ >array ]]
    rule = square " => "~ square
]=]

CONSTANT: pattern {
    { 46 35 46 }
    { 46 46 35 }
    { 35 35 35 }
}

: flip-rotate ( pattern -- patterns )
    { [ flip ] [ reverse ] [ [ reverse ] map ] } all-subsets
    [ [ call( x -- x ) ] each ] with map ;

: enhance ( rules pattern -- pattern' )
    dup length even? 2 3 ? [ '[ _ group ] map ] [ group ] bi
    [ flip ] map [ of ] with matrix-map [ stitch ] twice ;

MACRO: (part) ( n -- quot )
    '[ [ [ flip-rotate ] dip ] collect-assoc-by-multi
    [ first ] map-values pattern [ enhance ] with _ swap times
    concat [ CHAR: # = ] count ] ;

: part-1 ( rules -- n ) 5 (part) ;

: part-2 ( rules -- n ) 18 (part) ;
