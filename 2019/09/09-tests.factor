using: 2019.09 2019.intcode accessors dlists kernel literals
sequences tools.test ;
in: 2019.09.tests

: test ( str -- mem )
    prepare intcode-state new swap >>memory run ;

${
    "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
    prepare
} [
    "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
    prepare intcode-state new swap >>memory <dlist> >>outputs
    run outputs>> dlist>sequence reverse
] unit-test
{ 1219070632396864 } [
    "1102,34915192,34915192,7,4,7,99,0" prepare f input/output
] unit-test
{ 1125899906842624 }
[ "104,1125899906842624,99" prepare f input/output ] unit-test
{ 2745604242 } [ input-prepare part-1 ] unit-test
{ 51135 } [ input-prepare part-2 ] unit-test
