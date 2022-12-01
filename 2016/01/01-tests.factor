USING: 2016.01 tools.test ;

{ {  0  1 } } [ {  1  0 } "L" turn ] unit-test
{ { -1  0 } } [ {  0  1 } "L" turn ] unit-test
{ {  0 -1 } } [ { -1  0 } "L" turn ] unit-test
{ {  1  0 } } [ {  0 -1 } "L" turn ] unit-test
{ {  0 -1 } } [ {  1  0 } "R" turn ] unit-test
{ {  1  0 } } [ {  0  1 } "R" turn ] unit-test
{ {  0  1 } } [ { -1  0 } "R" turn ] unit-test
{ { -1  0 } } [ {  0 -1 } "R" turn ] unit-test

{ V{ V{ "R" 2 } V{ "L" 3 } } } [ "R2, L3" parse ] unit-test

{ 5 } [ "R2, L3" parse part-1 ] unit-test
{ 2 } [ "R2, R2, R2" parse part-1 ] unit-test
{ 12 } [ "R5, L5, R5, R3" parse part-1 ] unit-test
{ 231 } [ input part-1 ] unit-test

{ 4 } [ "R8, R4, R4, R8" parse part-2 ] unit-test
{ 147 } [ input part-2 ] unit-test
