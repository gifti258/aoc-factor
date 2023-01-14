using: kernel math math.combinatorics ranges sequences ;
in: 2015.17

! No Such Thing as Too Much
! Find number of container combinations fitting 150 liters
! part 2: … with the fewest number of containers

: transform ( seq quot -- range quot )
    [ dup length [0..b] ] dip '[
        0 [ sum 150 = 1 0 ? + ] reduce-combinations @
    ] with ; inline

: part-1 ( seq -- n ) [ ] transform map-sum ;

: part-2 ( seq -- n )
    [ [ zero? not ] keep and ] transform map-find drop ;
