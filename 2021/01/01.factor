USING: grouping math math.extras sequences ;
IN: 2021.01

! Sonar Sweep
! Count number of measurements smaller than previous measurement

: part-1 ( seq -- n ) 2 clump [ first2 < ] count ;

: part-2 ( seq -- n ) 3 moving-sum part-1 ;
