USING: aoc.matrices assocs combinators grouping kernel math
math.matrices math.parser math.vectors multiline peg.ebnf
sequences sequences.extras strings ;
IN: 2022.22

! Monkey Map
! Calculate password by following map and finding final position
! and direction
! part 2: the map is a cube

EBNF: (parse) [=[
    n = [0-9]+ => [[ dec> ]]
    turn = "R"|"L"
    line = (n turn?)+
]=]

: parse ( paragraph1 paragraph2 -- map path )
    [ dup [ length ] map-supremum '[
        _ over length - 32 <string> append
    ] map ] [ first (parse) ] bi* ;

CONSTANT: dirs { { 0 1 } { 1 0 } { 0 -1 } { -1 0 } }

: first-tile ( v -- index ) [ 32 = not ] find drop ;

: last-tile ( v -- index ) [ 32 = not ] find-last drop ;

: password ( pos dir -- n )
    [ 1 v+n { 1000 4 } v* sum ] [ dirs index ] bi* + ;

:: part-1 ( m path -- n )
    m first first-tile '{ 0 _ } :> pos!
    { 0 1 } :> dir!
    path [
        first2 :> ( n turn )
        n [
            pos dir v+ :> pos'
            pos' first2 :> ( row! col! )
            dir first zero? [
                col m first length rem col!
                { row col } m matrix-nth 32 = [
                    row m nth dir second neg?
                    [ last-tile ] [ first-tile ] if col!
                ] when
            ] [
                row m length rem row!
                { row col } m matrix-nth 32 = [
                    col m math.matrices:col dir first neg?
                    [ last-tile ] [ first-tile ] if row!
                ] when
            ] if
            { row col } :> pos'
            pos' m matrix-nth CHAR: # = [ pos' pos! ] unless
        ] times dir turn turns at [ vdotm ] when* dir!
    ] each pos dir password ;

SYMBOLS: h v t r l ;

CONSTANT: up {
    { { 0 1 } { { 3 0 } r } }
    { { 0 2 } { { 3 0 } v } }
    { { 1 1 } { { 0 1 } v } }
    { { 2 0 } { { 1 1 } r } }
    { { 2 1 } { { 1 1 } v } }
    { { 3 0 } { { 2 0 } v } }
}
CONSTANT: dn {
    { { 0 1 } { { 1 1 } v } }
    { { 0 2 } { { 1 1 } r } }
    { { 1 1 } { { 2 1 } v } }
    { { 2 0 } { { 3 0 } v } }
    { { 2 1 } { { 3 0 } r } }
    { { 3 0 } { { 0 2 } v } }
}
CONSTANT: lf {
    { { 0 1 } { { 2 0 } t } }
    { { 0 2 } { { 0 1 } h } }
    { { 1 1 } { { 2 0 } l } }
    { { 2 0 } { { 0 1 } t } }
    { { 2 1 } { { 2 0 } h } }
    { { 3 0 } { { 0 1 } l } }
}
CONSTANT: rt {
    { { 0 1 } { { 0 2 } h } }
    { { 0 2 } { { 2 1 } t } }
    { { 1 1 } { { 0 2 } l } }
    { { 2 0 } { { 2 1 } h } }
    { { 2 1 } { { 0 2 } t } }
    { { 3 0 } { { 2 1 } l } }
}
CONSTANT: id {
    { { 0 1 } { { 0 1 } f } }
    { { 0 2 } { { 0 2 } f } }
    { { 1 1 } { { 1 1 } f } }
    { { 2 0 } { { 2 0 } f } }
    { { 2 1 } { { 2 1 } f } }
    { { 3 0 } { { 3 0 } f } }
}

:: part-2 ( m path -- n )
    m [ 50 group ] map 50 group [ flip ] map :> m
    { 0 1 } :> face!
    { 0 0 } :> pos!
    { 0 1 } :> dir!
    path [
        first2 :> ( n turn )
        n [
            pos dir v+ :> pos'
            pos' first2 :> ( row! col! )
            face {
                { [ row 0 < ] [ 0 row! up ] }
                { [ col 0 < ] [ 0 col! lf ] }
                { [ row 50 = ] [ 49 row! dn ] }
                { [ col 50 = ] [ 49 col! rt ] }
                [ id ]
            } cond at first2 :> ( face' trans )
            dir :> dir'!
            trans {
                { h [ 49 col - col! ] }
                { v [ 49 row - row! ] }
                { t [
                    49 row - row!
                    dir { { -1 0 } { 0 -1 } } vdotm dir'!
                ] }
                { r [
                    row :> temp col row! temp col!
                    dir { { 0 -1 } { +1 0 } } vdotm dir'!
                ] }
                { l [
                    row :> temp col row! temp col!
                    dir { { 0 +1 } { -1 0 } } vdotm dir'!
                ] }
                [ drop ]
            } case
            { row col } :> pos'
            pos' face' m matrix-nth matrix-nth CHAR: # = [
                face' face! pos' pos! dir' dir!
            ] unless
        ] times dir turn turns at [ vdotm ] when* dir!
    ] each face 50 v*n pos v+ dir password ;
