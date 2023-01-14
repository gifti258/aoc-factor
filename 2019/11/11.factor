using: 2019.intcode accessors aoc.matrices assocs assocs.extras
deques dlists generalizations kernel math math.matrices
math.vectors ;
in: 2019.11

! Space Police
! part 1: count the number of tiles painted by the Intcode
! program
! part 2: read the registration identifier

: paint ( seq panels -- assoc )
    [ intcode-state new swap >>memory <dlist> >>outputs ]
    [ clone ] bi* { 0 0 } { 0 1 } [
        [ [ of 0 or 1dlist >>inputs ] 2keep ] dip
        reach run-until-output
        opcode>> 99 =
    ] [
        3 nover swap [ outputs>> pop-back ] 2dip set-at
        reach run-until-output outputs>> pop-back {
            { 0 { { 0 -1 } { 1 0 } } }
            { 1 { { 0 1 } { -1 0 } } }
        } at swap mdotv [ v+ ] keep
    ] until 2drop nip ;

: part-1 ( seq -- n ) h{ } paint assoc-size ;

: part-2 ( seq -- str )
    h{ { { 0 0 } 1 } } paint
    [ 1 = ] filter-values keys
    [ neg ] assoc-map
    matrix-format ;
