USING: 2019.02 2019.intcode accessors kernel literals tools.test
;
IN: 2019.02.tests

: test ( str -- mem )
    prepare intcode-state new swap >>memory run memory>> ;

${ "3500,9,10,70,2,3,11,0,99,30,40,50" prepare }
[ "1,9,10,3,2,3,11,0,99,30,40,50" test ] unit-test
${ "2,0,0,0,99" prepare } [ "1,0,0,0,99" test ] unit-test
${ "2,3,0,6,99" prepare } [ "2,3,0,3,99" test ] unit-test
${ "2,4,4,5,99,9801" prepare } [ "2,4,4,5,99,0" test ] unit-test
${ "30,1,1,4,2,5,6,0,99" prepare }
[ "1,1,1,4,99,5,6,0,99" test ] unit-test

{ 4570637 } [ input-prepare part-1 ] unit-test
{ 5485 } [ input-prepare part-2 ] unit-test
