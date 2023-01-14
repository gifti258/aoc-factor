using: accessors aoc.input aoc.md5 assocs kernel literals
math.order math.vectors path-finding sequences sequences.extras
sets ;
in: 2016.17

! Two Steps Forward
! Find shortest and longest path through maze

symbols: V U D L R ;

: path>string ( path -- str ) [ name>> ] map-concat ;

: path>loc ( path -- loc )
    [ {
        { U { 0 -1 } } { D { 0 1 } }
        { L { -1 0 } } { R { 1 0 } }
    } at ] map [ ] [ v+ ] map-reduce ;

: paths ( path -- seq )
    dup path>string $[ input-line ] prepend checksum
    { U D L R } [ [ "bcdef" in? ] dip and ] { } 2map-as sift
    [ suffix ] with
    [ path>loc [ 0 3 between? ] all? ] map-filter ;

tuple: doors < astar ;
m: doors cost ( from to astar -- n ) 3drop 1 ;
m: doors heuristic ( from to astar -- n ) 3drop 1 ;
m: doors neighbors ( path astar -- paths )
    drop paths [ dup path>loc { 3 3 } = [ drop V ] when ] map ;

: part-1 ( -- str )
    f V doors new find-path but-last last dup path>loc
    { { { 3 2 } D } { { 2 3 } R } } at suffix path>string ;

: part-2 ( path -- n )
    paths [
        dup path>loc { 3 3 } = [ length ] [ part-2 ] if
    ] map ?supremum ;
