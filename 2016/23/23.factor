USING: 2016.assembunny accessors assocs kernel math
math.combinatorics ;
IN: 2016.23

! Safe Cracking
! Value left in register a

: part-1 ( seq -- a )
    <assembunny-state> [ 7 "a" pick set-at ] change-registers
    run-program ;

: part-2 ( seq -- a ) part-1 7 factorial - 12 factorial + ;
