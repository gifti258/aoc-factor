using: 2016.assembunny accessors assocs kernel ;
in: 2016.12

! Leonardo's Monorail
! Value left in register a

: part-1 ( seq -- a ) <assembunny-state> run-program ;

: part-2 ( seq -- a )
    <assembunny-state> [ "c" over inc-at ] change-registers
    run-program ;
