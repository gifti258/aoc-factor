USING: 2019.intcode accessors deques dlists grouping
kernel math.combinatorics ranges sequences ;
IN: 2019.07

! Amplification Circuit
! Put Intcode computers in series to calculate the maximum
! thrust

: setup ( seq phases -- state-seq )
    [ 1dlist ] map 2 circular-clump [
        intcode-state new
            swap first2 [ >>inputs ] [ >>outputs ] bi*
            swap clone >>memory
    ] with map 0 over first inputs>> push-front ;

: amplify ( seq phases -- thrust )
    setup [ run-until-output ] map last outputs>> peek-front ;

: part-1 ( seq -- signal )
    5 <iota> [ amplify ] with map-permutations supremum ;

: amplify* ( seq phases -- thrust )
    setup [
        [ run-until-output ] map
        dup last opcode>> 99 = not
    ] loop last outputs>> peek-front ;

: part-2 ( seq -- signal )
    5 9 [a..b] [ amplify* ] with map-permutations supremum ;
