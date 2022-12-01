USING: arrays bit-sets combinators kernel math math.order
math.parser math.vectors multiline peg.ebnf ranges sequences
sequences.product sets ;
IN: 2015.06

! Probably a Fire Hazard
! part 1: count lit lights
! part 2: determine total brightness

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    point = n ","~ n
    instruction = ("toggle"|"turn on"|"turn off") " "~ point
        " through "~ point
]=]

: handle-pairs ( obj rect quot -- obj' )
    [ flip [ first2 [a..b] ] map ] dip
    '[ { 1000 1 } v* sum over @ ] product-each ; inline

: handle-pairs* ( seq quot -- seq' )
    '[ _ change-nth ] handle-pairs ; inline

: part-1 ( seq -- n )
    1,000,000 <bit-set> swap [
        unclip {
            { "turn on" [ [ adjoin ] handle-pairs ] }
            { "turn off" [ [ delete ] handle-pairs ] }
            { "toggle" [ [
                2dup in? [ delete ] [ adjoin ] if ] handle-pairs
            ] }
        } case
    ] each cardinality ;

: part-2 ( seq -- n )
    1,000,000 0 <array> swap [
        unclip {
            { "turn on" [ [ 1 + ] handle-pairs* ] }
            { "turn off" [ [ 1 [-] ] handle-pairs* ] }
            { "toggle" [ [ 2 + ] handle-pairs* ] }
        } case
    ] each sum ;
