USING: eval kernel math prettyprint sequences ;
IN: 2015.08

! Matchsticks
! part 1: calculate escape character count
! part 2: escape again and calculate escape character count

: count ( seq seq -- n ) [ [ length ] map-sum ] bi@ - ;

: part-1 ( seq -- n ) dup [ eval( -- str ) ] map count ;

: part-2 ( seq -- n ) [ [ unparse ] map ] keep count ;
