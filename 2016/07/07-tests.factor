USING: 2016.07 aoc.input sequences tools.test ;

{ t } [ "abba[mnop]qrst" parse flip tls? ] unit-test
{ f } [ "abcd[bddb]xyyx" parse flip tls? ] unit-test
{ f } [ "aaaa[qwer]tyui" parse flip tls? ] unit-test
{ t } [ "ioxxoj[asdfgh]zxcvbn" parse flip tls? ] unit-test

{ t } [ "aba[bab]xyz" parse flip ssl? ] unit-test
{ f } [ "xyx[xyx]xyx" parse flip ssl? ] unit-test
{ t } [ "aaa[kek]eke" parse flip ssl? ] unit-test
{ t } [ "zazbz[bzb]cdb" parse flip ssl? ] unit-test

{ 110 } [ input-parse parse* part-1 ] unit-test
{ 242 } [ input-parse parse* part-2 ] unit-test
