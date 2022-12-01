USING: arrays combinators combinators.smart kernel math
math.matrices sequences sequences.extras
sequences.generalizations splitting ;
USE: multiline
IN: aoc.matrices

/*
: upper-neighbors ( m -- m' )
    [ dimension first dup -1 <simple-eye> ] keep mdot ;

: lower-neighbors ( m -- m' )
    [ dimension first dup 1 <simple-eye> ] keep mdot ;

: left-neighbors ( m -- m' )
    dup dimension second dup 1 <simple-eye> mdot ;

: right-neighbors ( m -- m' )
    dup dimension second dup -1 <simple-eye> mdot ;

ALIAS: matrix-shl right-neighbors
ALIAS: matrix-shr left-neighbors
ALIAS: matrix-shu lower-neighbors
ALIAS: matrix-shd upper-neighbors
*/

: upper-toroidal-neighbors ( m -- m' ) -1 rotate ;
: lower-toroidal-neighbors ( m -- m' ) 1 rotate ;
/*
: left-toroidal-neighbors ( m -- m' ) [ -1 rotate ] map ;
: right-toroidal-neighbors ( m -- m' ) [ 1 rotate ] map ;
*/

ALIAS: matrix-rou lower-toroidal-neighbors
ALIAS: matrix-rod upper-toroidal-neighbors
/*
ALIAS: matrix-rol right-toroidal-neighbors
ALIAS: matrix-ror left-toroidal-neighbors
*/

: matrix-sum ( m -- n ) [ sum ] map-sum ;

: matrix-map-sum ( m1 m2 quot -- n )
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

: cardinal-coordinate-neighbors ( pair -- pairs ) ;

: coordinate-neighbors ( pair -- pairs ) ;

: matrix>pairs ( matrix quot -- pairs )
    '[ 2array _ dip and ] matrix-map-index concat sift ; inline

: matrix-format ( pairs -- str )
    1 swap dup flip [ supremum 1 + ] map
    first2 <zero-matrix> [ matrix-set-nths ] keep flip
    [ [ zero? CHAR: \s CHAR: * ? ] "" map-as ] map join-lines ;
