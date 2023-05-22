USING: aoc.matrices assocs generalizations grouping hash-sets
kernel literals math math.matrices math.vectors multiline
sequences sets ;
IN: 2017.22

! Sporifica Virus
! Count infection causing bursts out of 10,000/10,000,000

: part-1 ( m -- n )
    [ 0 { -1 0 } ] dip [ dimension [ 1 - 2 / ] map ] keep
    [ 1 = ] matrix>pairs >hash-set 10,000 [
        2dup in?
        [ [ 1 + ] unless ] [
            { { 0 -1 } { 1 0 } } { { 0 1 } { -1 0 } } ?
            vdotm dup
        ] [ drop [ v+ ] keep ]
        [ [ [ delete ] [ adjoin ] if ] keepd ]
        4 cleave-curry 4 spread*
    ] times 3drop ;

SYMBOLS: +c+ +w+ +i+ +f+ ;

CONSTANT: turns {
    { +c+ { { 0 +1 } { -1 0 } } }
    { +w+ { { +1 0 } { 0 +1 } } }
    { +i+ { { 0 -1 } { +1 0 } } }
    { +f+ { { -1 0 } { 0 -1 } } }
}

CONSTANT: state-transitions $[
    { +c+ +w+ +i+ +f+ } 2 circular-clump
]

: part-2 ( m -- n )
    [ 0 { -1 0 } ] dip [ dimension [ 1 - 2 / ] map ] keep
    [ 1 = ] matrix>pairs [ +i+ ] H{ } map>assoc 10,000,000 [
        2dup at +c+ or
        [ +w+ = [ 1 + ] when ]
        [ turns at vdotm dup ]
        [ drop [ v+ ] keep ]
        [ state-transitions at -rot [ set-at ] keep ]
        4 cleave-curry 4 spread*
    ] times 3drop ;
