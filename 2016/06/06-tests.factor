USING: 2016.06 aoc.input multiline sequences splitting
tools.test ;
IN: 2016.06.tests

CONSTANT: msg [[ eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar]]

{ "easter" } [ msg string-lines part-1 ] unit-test
{ "advent" } [ msg string-lines part-2 ] unit-test

{ "gebzfnbt" } [ input-lines part-1 ] unit-test
{ "fykjtwyn" } [ input-lines part-2 ] unit-test
