using: kernel math math.vectors sequences sequences.extras
vectors ;
in: 2018.08

! Memory Maneuver
! Parse license file:
! part 1: calculate sum of metadata entries
! part 2: calculate root node value

: metadata-sum ( seq -- seq n )
    dup pop over pop
    [ [ metadata-sum ] replicate sum ]
    [ swapd [ dup pop ] replicate sum ] bi* swapd + ;

: node-value ( seq -- seq n )
    dup pop over pop
    [ [ node-value ] replicate ]
    [ swapd [ dup pop ] replicate ] bi* swapd
    over empty? [ nip sum ] [
        1 v-n [ swap ?nth ] with map-sift sum
    ] if ;

: part-1 ( seq -- n ) >vector reverse metadata-sum nip ;

: part-2 ( seq -- n ) >vector reverse node-value nip ;
