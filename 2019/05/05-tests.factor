USING: 2019.05 2019.intcode accessors kernel literals tools.test
;
IN: 2019.05.tests

: test ( str -- mem )
    prepare intcode-state new swap >>memory run memory>> ;

{ 0 } [ "3,0,4,0,99" prepare 0 input/output ]
unit-test
${ "1002,4,3,4,99" prepare } [ "1002,4,3,4,33" test ] unit-test
${ "1101,100,-1,4,99" prepare } [ "1101,100,-1,4,0" test ]
unit-test
{ 15259545 } [ input-prepare part-1 ] unit-test

{ 1 }
[ "3,9,8,9,10,9,4,9,99,-1,8" prepare 8 input/output ]
unit-test
{ 0 }
[ "3,9,8,9,10,9,4,9,99,-1,8" prepare 0 input/output ]
unit-test
{ 1 }
[ "3,9,7,9,10,9,4,9,99,-1,8" prepare 0 input/output ]
unit-test
{ 0 }
[ "3,9,7,9,10,9,4,9,99,-1,8" prepare 8 input/output ]
unit-test
{ 1 }
[ "3,3,1108,-1,8,3,4,3,99" prepare 8 input/output ]
unit-test
{ 0 }
[ "3,3,1108,-1,8,3,4,3,99" prepare 0 input/output ]
unit-test
{ 1 }
[ "3,3,1107,-1,8,3,4,3,99" prepare 0 input/output ]
unit-test
{ 0 }
[ "3,3,1107,-1,8,3,4,3,99" prepare 8 input/output ]
unit-test
{ 1000 }
[ "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99"
prepare 8 input/output ] unit-test
{ 7616021 } [ input-prepare part-2 ] unit-test
