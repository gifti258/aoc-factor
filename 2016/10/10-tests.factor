using: 2016.10 aoc.input assocs kernel literals multiline
sequences splitting tools.test ;
in: 2016.10.tests

constant: example $[ [[ value 5 goes to bot 2
bot 2 gives low to bot 1 and high to bot 0
value 3 goes to bot 1
bot 1 gives low to output 1 and high to bot 0
bot 0 gives low to output 2 and high to output 0
value 2 goes to bot 2]] string-lines [ parse ] map ]

{ 2 } [ example run drop { 2 5 } of second ] unit-test
{ 181 } [ input-parse part-1 ] unit-test

{ 30 } [ example part-2 ] unit-test
{ 12567 } [ input-parse part-2 ] unit-test
