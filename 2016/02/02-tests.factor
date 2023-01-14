using: 2016.02 aoc.input tools.test ;
in: 2016.02.tests

constant: instructions {
    "ULL"
    "RRDDD"
    "LURDL"
    "UUUUD"
}

{ "1985" } [ instructions part-1 ] unit-test
{ "24862" } [ input-lines part-1 ] unit-test

{ "5DB3" } [ instructions part-2 ] unit-test
{ "46C91" } [ input-lines part-2 ] unit-test
