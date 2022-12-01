USING: assocs kernel math.matrices math.matrices.extras
math.statistics ranges sequences ;
IN: 2021.06

! Lanternfish
! Track population after 80/256 days

CONSTANT: matrix {
    { 0 0 0 0 0 0 1 0 1 }
    { 1 0 0 0 0 0 0 0 0 }
    { 0 1 0 0 0 0 0 0 0 }
    { 0 0 1 0 0 0 0 0 0 }
    { 0 0 0 1 0 0 0 0 0 }
    { 0 0 0 0 1 0 0 0 0 }
    { 0 0 0 0 0 1 0 0 0 }
    { 0 0 0 0 0 0 1 0 0 }
    { 0 0 0 0 0 0 0 1 0 }
}

: nth-day ( seq n -- n )
    [ histogram 8 [0..b] [ of 0 or ] with map matrix ] dip
    m^n vdotm sum ;

: part-1 ( seq -- n ) 80 nth-day ;

: part-2 ( seq -- n ) 256 nth-day ;
