USING: kernel math math.combinatorics sequences ;
IN: 2020.01

! Report Repair
! Find the product of the two/three numbers that add up to 2020

: part-1 ( seq -- n ) dup [ + 2020 = ] cartesian-find * ;

: part-2 ( seq -- n ) 3 [ sum 2020 = ] find-selection product ;
