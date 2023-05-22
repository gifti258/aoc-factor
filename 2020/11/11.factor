USING: aoc.matrices kernel math math.matrices math.order ;
IN: 2020.11

! Seating System
! part 1: number of seats occupied after system stabilizes

: parse ( seq -- empty occupied )
    [ [ CHAR: L = 1 0 ? ] matrix-map ]
    [ [ CHAR: # = 1 0 ? ] matrix-map ] bi ;

:: round ( empty occupied -- empty' occupied' )
    occupied neighbor-sum [ 0 = 1 0 ? ] matrix-map
    empty [ bitand ] matrix-2map :> e->o
    occupied neighbor-sum [ 4 >= 1 0 ? ] matrix-map
    occupied [ bitand ] matrix-2map :> o->e
    empty e->o [ [-] ] matrix-2map :> e->e
    occupied o->e [ [-] ] matrix-2map :> o->o
    e->e o->e m+ o->o e->o m+ ;

: part-1 ( empty occupied -- n )
    [ over = ]
    [ [ round ] keep ] do until nip matrix-sum ;
