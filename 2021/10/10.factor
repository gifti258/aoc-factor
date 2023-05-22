USING: arrays assocs assocs.extras grouping kernel math
math.order math.parser math.statistics sequences sets ;
IN: 2021.10

! Syntax Scoring
! part 1: corrupted lines total syntax error score
! part 2: incomplete lines completion score median

: prepare ( seq -- seq' )
    [
        [ V{ } clone ] dip [
            dup "([{<" in? [ over push f ]
            [ over pop - abs 1 2 between? not ] if
        ] find nip 2array
    ] map ;

: part-1 ( seq -- n )
    prepare values sift [
        ")]}>" { 3 57 1197 25137 } zip at 0 or
    ] map-sum ;

: part-2 ( seq -- n )
    prepare [ ] reject-values keys [
        reverse [ "(1[2{3<4" 2 group at ] map 5 base>
    ] map median ;
