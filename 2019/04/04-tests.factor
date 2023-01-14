using: 2019.04 aoc.input tools.test ;

{ t } [ "111111" possible? ] unit-test
{ f } [ "223450" possible? ] unit-test
{ f } [ "123789" possible? ] unit-test
{ 1063 } [ input-line parse part-1 ] unit-test

{ t } [ "112233" possible?* ] unit-test
{ f } [ "123444" possible?* ] unit-test
{ t } [ "111122" possible?* ] unit-test
{ 686 } [ input-line parse part-2 ] unit-test
