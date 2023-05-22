USING: aoc.groups math math.vectors ;
IN: 2018.25

! Four-Dimensional Adventure
! Find number of constellations (groups of points with distance
! <= 3)

: part-1 ( seq -- n ) [ v- l1-norm 3 <= ] count-groups ;
