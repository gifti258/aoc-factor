USING: 2019.intcode accessors deques dlists kernel literals
multiline ;
IN: 2019.21

! Springoid Adventure
! Get hull damage report

CONSTANT: part-1
[[ OR A J
AND B J
AND C J
NOT J J
AND D J
WALK
]]

CONSTANT: part-2
[[ OR A J
AND B J
AND C J
NOT J J
AND D J
OR E T
OR H T
AND T J
RUN
]]

: springscript ( str -- state )
    intcode-state new
        $[ input-prepare ] clone >>memory
        <dlist> >>outputs
        swap <dlist> [ push-all-front ] keep >>inputs
    run outputs>> peek-front ;
