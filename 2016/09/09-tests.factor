USING: 2016.09 aoc.input tools.test ;

{ 6 } [ "ADVENT" part-1 ] unit-test
{ 7 } [ "A(1x5)BC" part-1 ] unit-test
{ 9 } [ "(3x3)XYZ" part-1 ] unit-test
{ 11 } [ "A(2x2)BCD(2x2)EFG" part-1 ] unit-test
{ 6 } [ "(6x1)(1x3)A" part-1 ] unit-test
{ 18 } [ "X(8x2)(3x3)ABCY" part-1 ] unit-test
{ 98135 } [ input-line part-1 ] unit-test

{ 9 } [ "(3x3)XYZ" part-2 ] unit-test
{ 20 } [ "X(8x2)(3x3)ABCY" part-2 ] unit-test
{ 241920 } [ "(27x12)(20x12)(13x14)(7x10)(1x12)A" part-2 ]
unit-test
{ 445 } [
    "(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN"
    part-2
] unit-test
{ 10964557606 } [ input-line part-2 ] unit-test
