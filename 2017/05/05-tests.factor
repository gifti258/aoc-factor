USING: 2017.05 aoc.input kernel tools.test ;
IN: 2017.05.tests

CONSTANT: test V{ 0 3 0 1 -3 }

{ 5 } [ test clone part-1 ] unit-test
{ 381680 } [ input-ns part-1 ] unit-test

{ 10 } [ test part-2 ] unit-test
{ 29717847 } [ input-ns part-2 ] unit-test
