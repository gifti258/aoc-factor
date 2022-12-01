USING: 2019.01 aoc.input tools.test ;

{ 2 } [ 12 mass>fuel ] unit-test
{ 2 } [ 14 mass>fuel ] unit-test
{ 654 } [ 1969 mass>fuel ] unit-test
{ 33583 } [ 100756 mass>fuel ] unit-test
{ 3184233 } [ input-ns part-1 ] unit-test

{ 2 } [ 14 mass>fuel* ] unit-test
{ 966 } [ 1969 mass>fuel* ] unit-test
{ 50346 } [ 100756 mass>fuel* ] unit-test
{ 4773483 } [ input-ns part-2 ] unit-test
