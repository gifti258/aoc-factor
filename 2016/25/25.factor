USING: 2016.assembunny accessors assocs kernel math
sequences.repeating ;
IN: 2016.25

! Clock Signal
! Find lowest input to generate clock signal

: clock-signal? ( seq n -- ? )
    [ <assembunny-state> ] dip
    '[ _ "a" pick set-at ] change-registers
    run-program* V{ 0 1 } 12 cycle = ;

: part-1 ( seq -- n ) 256 [ clock-signal? ] with find-integer ;
