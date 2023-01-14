using: 2019.03 aoc.input literals multiline sequences splitting
tools.test ;
in: 2019.03.tests

<< : prepare ( str -- seq )
    string-lines [ parse ] map ; >>

constant: test1 $[ [[ R8,U5,L5,D3
U7,R6,D4,L4]] prepare ]
constant: test2 $[ [[ R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83]] prepare ]
constant: test3 $[ [[ R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7]] prepare ]

{ 6 } [ test1 part-1 ] unit-test
{ 159 } [ test2 part-1 ] unit-test
{ 135 } [ test3 part-1 ]
unit-test
{ 1225 } [ input-parse part-1 ] unit-test

{ 30 } [ test1 part-2 ] unit-test
{ 610 } [ test2 part-2 ] unit-test
{ 410 } [ test3 part-2 ] unit-test
{ 107036 } [ input-parse part-2 ] unit-test
