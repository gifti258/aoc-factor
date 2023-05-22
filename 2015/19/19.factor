USING: grouping kernel math multiline peg.ebnf sequences sets
strings ;
IN: 2015.19

! Medicine for Rudolph
! part 1: number of distinct molecules after one replacement
! part 2: fewest number of steps to create target molecule

EBNF: (parse) [=[
	str = [A-Za-z]+ => [[ >string ]]
	rule = str " => "~ str
]=]

: parse ( replacements molecule -- assoc str )
    [ [ (parse) ] map ] [ first ] bi* ;

:: replace ( old new molecule -- seq )
    molecule old length clump
    [ [ old = ] dip and ] map-index sift
    [ new swap dup old length + molecule snip surround ] map ;

: replacements ( assoc str -- seq )
    '[ first2 _ replace ] gather ;

: part-1 ( assoc str -- n ) replacements cardinality ;

: part-2 ( assoc str -- n )
    0 spin [ reverse ] map
    [ dup "e" = ] [
        replacements first [ 1 + ] dip
    ] with until drop ;
