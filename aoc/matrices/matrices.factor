using: arrays combinators combinators.smart kernel math
math.matrices math.vectors sequences sequences.extras
sequences.generalizations splitting ;
use: multiline
in: aoc.matrices

: left-neighbors ( m -- m' )
    dup dimension second dup 1 <simple-eye> mdot ;

: right-neighbors ( m -- m' )
    dup dimension second dup -1 <simple-eye> mdot ;

: upper-neighbors ( m -- m' )
    [ dimension first dup -1 <simple-eye> ] keep mdot ;

/*
: lower-neighbors ( m -- m' )
    [ dimension first dup 1 <simple-eye> ] keep mdot ;
*/

alias: matrix-shl right-neighbors
alias: matrix-shr left-neighbors
! alias: matrix-shu lower-neighbors
alias: matrix-shd upper-neighbors

: upper-toroidal-neighbors ( m -- m' ) -1 rotate ;
: lower-toroidal-neighbors ( m -- m' ) 1 rotate ;
/*
: left-toroidal-neighbors ( m -- m' ) [ -1 rotate ] map ;
: right-toroidal-neighbors ( m -- m' ) [ 1 rotate ] map ;
*/

alias: matrix-rou lower-toroidal-neighbors
alias: matrix-rod upper-toroidal-neighbors
/*
alias: matrix-rol right-toroidal-neighbors
alias: matrix-ror left-toroidal-neighbors
*/

: matrix-sum ( m -- n ) [ sum ] map-sum ;

: matrix-map-sum ( m quot -- n )
    '[ _ map-sum ] map-sum ; inline

: matrix-2map ( m1 m2 quot -- m ) '[ _ 2map ] 2map ; inline

: matrix-2map-sum ( m1 m2 quot -- m )
    '[ _ 2map-sum ] 2map-sum ; inline

: matrix-3map ( m1 m2 m3 quot -- m ) '[ _ 3map ] 3map ; inline

: matrix-4map ( m1 m2 m3 m4 quot -- m )
    '[ _ 4 nmap ] 4 nmap ; inline

: cardinal-neighbor-map ( m quot -- m' )
    [ {
        [ [ rest f suffix ] map ]
        [ [ but-last f prefix ] map ]
        [ [ rest f suffix ] column-map ]
        [ [ but-last f prefix ] column-map ]
    } cleave ] dip '[ 4array @ ] matrix-4map ; inline

: cardinal-neighbor-infimum ( m -- m' )
    [ ?infimum ] cardinal-neighbor-map ;

: cardinal-neighbor-sum ( m -- m' )
    [
        dimension [
            { -1 1 } [
                dupd <simple-eye>
            ] with [ m+ ] map-reduce
        ] map first2
    ] keep swap dupd [ mdot ] 2bi@ m+ ;

/*
: diagonal-neighbor-sum ( m -- m' )
    [
        dimension [
            { -1 1 } [
                dupd <simple-eye>
            ] with [ m+ ] map-reduce
        ] map first2
    ] keep swap mdot mdot ;
*/

: neighbor-sum ( m -- m' )
    [
        [
            dimension [
                { -1 0 1 } [
                    dupd <simple-eye>
                ] with [ m+ ] map-reduce
            ] map first2
        ] keep swap mdot mdot
    ] keep m- ;

/*
: cardinal-toroidal-neighbor-sum ( m -- m' )
    [ {
        [ upper-toroidal-neighbors ]
        [ lower-toroidal-neighbors ]
        [ left-toroidal-neighbors ]
        [ right-toroidal-neighbors ]
    } cleave ] [ m+ ] reduce-outputs ;

: diagonal-toroidal-neighbor-sum ( m -- m' )
    [ {
        [ upper-toroidal-neighbors left-toroidal-neighbors ]
        [ upper-toroidal-neighbors right-toroidal-neighbors ]
        [ lower-toroidal-neighbors left-toroidal-neighbors ]
        [ lower-toroidal-neighbors right-toroidal-neighbors ]
    } cleave ] [ m+ ] reduce-outputs ;

: toroidal-neighbor-sum ( m -- m' )
    [ cardinal-toroidal-neighbor-sum ]
    [ diagonal-toroidal-neighbor-sum ] bi m+ ;
*/

constant: ch>direction {
    { char: ^ { 0 -1 } }
    { char: v { 0 +1 } }
    { char: > { +1 0 } }
    { char: < { -1 0 } }
}

constant: turns {
    { "L" { { 0 +1 } { -1 0 } } }
    { "R" { { 0 -1 } { +1 0 } } }
}

: cardinal-coordinate-neighbors ( pair -- pairs )
    { { 0 1 } { 0 -1 } { 1 0 } { -1 0 } } [ v+ ] with map ;

: coordinate-neighbors ( pair -- pairs )
    {
        { 1 0 } { -1 0 } { 0 1 } { 0 -1 }
        { 1 1 } { 1 -1 } { -1 1 } { -1 -1 }
    } [ v+ ] with map ;

: matrix>pairs ( matrix quot -- pairs )
    '[ 2array _ dip and ] matrix-map-index concat sift ; inline

: matrix-format ( pairs -- str )
    1 swap dup flip [ supremum 1 + ] map
    first2 <zero-matrix> [ matrix-set-nths ] keep flip
    [ [ zero? char: \s char: * ? ] "" map-as ] map join-lines ;
