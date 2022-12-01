USING: 2019.intcode aoc.matrices accessors arrays deques dlists
kernel math.matrices math.vectors sequences ;
IN: 2019.19

! Tractor Beam
! part 1: number of points affected by beam in 50x50 area
! part 2: find closest 100x100 square within the beam

<< : input ( -- seq ) input-prepare ; >>

: output ( loc -- state )
    intcode-state new
        input >>memory
        <dlist> >>outputs
        swap <dlist> [ push-all-front ] keep >>inputs
    run outputs>> peek-front ;

: part-1 ( -- n )
    50 dup [ 2array output ] <matrix-by-indices> matrix-sum ;

: closest-point ( loc -- loc/f )
    [ { -99 99 } v+ output ] keep { -99 0 } v+ [ 1 = ] dip f ? ;

: next-point ( loc -- loc )
    { 1 1 } v+ [
        [ { 1 0 } v+ [ output 1 = ] keep ] keep [ ? ] keepdd
    ] loop ;

: part-2 ( -- n )
    { 11 9 } [
        [ closest-point dup ] keep next-point [ ? ] keepdd not
    ] loop { 10000 1 } v* sum ;
