using: 2016.12 aoc.input literals multiline sequences splitting
tools.test ;
in: 2016.12.tests

constant: test-word-lines $[ [[ cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a]] string-lines [ split-words ] map ]

{ 42 } [ test-word-lines part-1 ] unit-test
{ 318003 } [ input-word-lines part-1 ] unit-test
{ 9227657 } [ input-word-lines part-2 ] unit-test
