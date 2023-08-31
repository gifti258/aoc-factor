USING: aoc.input kernel literals math math.vectors path-finding
sequences sequences.extras sets ;
IN: 2016.13

! A Maze of Twisty Little Cubicles
! part 1: fewest number of steps to reach 31,39
! part 2: number of locations reachable with 50 steps

:: open? ( x y -- ? )
    x sq x 3 * + x y * 2 * + y + y sq + $[ input-n ] +
    [ dup 0 > ] [ 2 /mod ] produce nip sum even? ;

: neighbors* ( loc -- seq )
    { { 1 0 } { -1 0 } { 0 1 } { 0 -1 } } [ v+ ] with
    [ [ [ neg? ] none? ] [ first2 open? ] bi and ] map-filter ;

TUPLE: cubicles < astar ;
M: cubicles cost ( from to astar -- n ) 3drop 1 ;
M: cubicles heuristic ( from to astar -- n ) drop v- l1-norm ;
M: cubicles neighbors ( node astar -- seq ) drop neighbors* ;

: part-1 ( -- n )
    { 1 1 } { 31 39 } cubicles new find-path length 1 - ;

: traverse ( path -- seq )
    [ last neighbors* ] [ without ] [ [ swap [
        suffix dup length 50 > [ traverse ] unless
    ] with map ] keep suffix union-all ] tri ;

: part-2 ( -- n ) { { 1 1 } } traverse length ;
