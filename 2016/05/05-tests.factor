USING: 2016.05 aoc.input tools.test ;
IN: 2016.05.tests

CONSTANT: example "abc"

{ "18f47a30" } [ example part-1 ] long-unit-test
{ "05ace8e3" } [ example part-2 ] long-unit-test

{ "c6697b55" } [ input-line part-1 ] long-unit-test
{ "8c35d1ab" } [ input-line part-2 ] long-unit-test
