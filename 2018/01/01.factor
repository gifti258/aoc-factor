USING: kernel math sequences sets ;
IN: 2018.01

! Chronal Calibration
! part 1: frequency sum
! part 2: first repeated frequency

: part-1 ( seq -- n ) sum ;

: part-2 ( seq -- n )
    HS{ } clone 0 0 [
        [ pick dupd nth ] dip + pick dupd ?adjoin
    ] [
        [ 1 + pick length mod ] dip
    ] while 3nip ;
