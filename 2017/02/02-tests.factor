using: 2017.02 aoc.input math.parser multiline sequences
splitting tools.test ;
in: 2017.02.tests

: prepare ( str -- seq )
    split-lines [ split-words [ dec> ] map ] map ;

{ 18 } [ [[ 5 1 9 5
7 5 3
2 4 6 8]] prepare part-1 ] unit-test
{ 45972 } [ input-tsn-lines part-1 ] unit-test
{ 9 } [ [[ 5 9 2 8
9 4 7 3
3 8 6 5]] prepare part-2 ] unit-test
{ 326 } [ input-tsn-lines part-2 ] unit-test
