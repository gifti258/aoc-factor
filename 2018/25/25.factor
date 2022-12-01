USING: aoc.groups math math.vectors sequences ;
IN: 2018.25

! Four-Dimensional Adventure
! Find number of constellations (groups of points with distance
! <= 3)

: part-1 ( seq -- n ) [ v- [ abs ] map-sum 3 <= ] count-groups ;
