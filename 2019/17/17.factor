USING: 2019.intcode accessors aoc.matrices deques dlists kernel
math math.matrices multiline sequences splitting ;
IN: 2019.17

! Set and Forget
! part 1: sum the product of the coordinates of path
! intersections
! part 2: divide path into movement functions and collect dust

: camera-view ( seq -- seq )
    intcode-state new swap >>memory <dlist> >>outputs run
    outputs>> dlist>sequence reverse
    { 10 } split 2 head* ;

: alignment-parameter-sum ( seq -- n )
    [ cardinal-neighbor-sum ] keep m+
    [ CHAR: # 5 * = ] matrix>pairs [ product ] map-sum ;

: part-1 ( seq -- n ) camera-view alignment-parameter-sum ;

CONSTANT: input-string [[ A,B,A,C,B,C,A,B,A,C
R,6,L,10,R,8,R,8
R,12,L,8,L,10
R,12,L,10,R,6,L,10
n
]]

: part-2 ( seq -- seq )
    2 0 pick set-nth
    intcode-state new swap >>memory
    input-string <dlist> [ push-all-front ] keep >>inputs
    <dlist> >>outputs run
    outputs>> peek-front ;
