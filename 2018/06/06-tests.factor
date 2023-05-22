USING: 2018.06 aoc.input literals multiline sequences splitting
tools.test ;
IN: 2018.06.tests

CONSTANT: test $[ [[ 1, 1
1, 6
8, 3
3, 4
5, 5
8, 9]] split-lines [ parse ] map ]

{ 17 } [ test part-1 ] unit-test
{ 3251 } [ input-parse part-1 ] unit-test
{ 16 } [ test 32 part-2 ] unit-test
{ 47841 } [ input-parse 10000 part-2 ] unit-test
