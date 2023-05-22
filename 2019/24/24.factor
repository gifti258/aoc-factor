USING: aoc.matrices kernel math sequences ;
IN: 2019.24

! Planet of Discord
! part 1: biodiversity rating of first layout appearing twice
! part 2: number of bugs after 200 steps

: step ( seq -- seq )
    [ cardinal-neighbor-sum ] keep
    [ { { 0 1 1 0 0 } { 0 1 0 0 0 } } nth nth ] matrix-2map ;

: part-1 ( m -- n )
    f swap [
        [ suffix ] keep step dup pick index not
    ] loop nip concat 0 [ 2^ * + ] reduce-index ;
