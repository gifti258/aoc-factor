USING: arrays assocs grouping hashtables kernel
math.combinatorics math.order math.parser multiline peg.ebnf
sequences strings ;
IN: 2015.13

! Knights of the Dinner Table
! Find the seating arrangement with the most total happiness
! part 2: … including yourself

EBNF: parse [=[
    person = [a-zA-Z]+ => [[ >string ]]
    gain = "gain" => [[ "+" ]]
    loss = "lose" => [[ "-" ]]
    sign = gain|loss
    units = sign " "~ [0-9]+ => [[ concat dec> ]]
    rule = person " would "~ units
        " happiness units by sitting next to "~ person "."~
]=]

: setup ( seq -- assoc seq )
    H{ } clone swap [
        first3 [ over ] 2dip [ rot ?set-at ] 2curry change-at
    ] each dup keys ;

: find-maximum ( assoc seq -- n )
    0 [ 2 circular-clump [
        dup reverse 2array [ first2 reach at at ] map-sum
    ] map-sum max ] reduce-permutations nip ;

: part-1 ( seq -- n ) setup find-maximum ;

: part-2 ( seq -- n )
    setup [ [ over [ 0 "myself" pick set-at ] change-at ] each ]
    [ [ 0 ] H{ } map>assoc "myself" pick set-at ]
    [ "myself" suffix ] tri find-maximum ;
