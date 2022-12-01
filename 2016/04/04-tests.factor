USING: 2016.04 aoc.input tools.test ;

{ t } [ "aaaaa-bbb-z-y-x-123[abxyz]" parse real? ] unit-test
{ t } [ "a-b-c-d-e-f-g-h-987[abcde]" parse real? ] unit-test
{ t } [ "not-a-real-room-404[oarel]" parse real? ] unit-test
{ f } [ "totally-real-room-200[decoy]" parse real? ] unit-test
{ 278221 } [ input-parse part-1 ] unit-test
{ "very encrypted name" } [
    { "qzmt-zixmtkozy-ivhz" 343 } decrypt
] unit-test
{ 267 } [ input-parse part-2 ] unit-test
