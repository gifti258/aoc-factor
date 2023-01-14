using: 2019.17 2019.intcode literals multiline sequences
splitting tools.test ;
in: 2019.17.tests

constant: test $[ [[
..#..........
..#..........
#######...###
#.#...#...#.#
#############
..#...#...#..
..#####...^..]] rest split-lines ]
{ 76 } [ test alignment-parameter-sum ] unit-test
{ 8408 } [ input-prepare part-1 ] unit-test
{ 1168948 } [ input-prepare part-2 ] unit-test
