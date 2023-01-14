using: sequences sets ;
in: 2020.06

! Custom Customs
! Count positive answers per group
! part 1: by anyone
! part 2: by everyone

: part-1 ( seq -- n ) [ union-all length ] map-sum ;

: part-2 ( seq -- n ) [ intersect-all length ] map-sum ;
