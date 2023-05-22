USING: accessors assocs continuations grouping kernel math
math.parser math.statistics multiline peg.ebnf sequences
sequences.extras sets strings ;
IN: 2017.07

! Recursive Circus
! part 1: find root program
! part 2: find correct weight to balance tower

EBNF: parse [=[
    name = [a-z]+ => [[ >string ]]
    n = [0-9]+ => [[ dec> ]]
    program = name " ("~ n ")"~ (" -> "~ (name (", "?)~)+)?
]=]

ERROR: imbalanced weight-needed ;

: part-1 ( seq -- str )
    [ [ first ] map ] [ [ third ] map-concat ] bi diff first ;

: at ( name seq -- seq ) [ first = ] with find nip ;

: weight ( name seq -- n )
    [ at [ second ] [ third ] bi ] keep
    [ '[ _ weight ] map dup all-equal? ] 2keep '[
        [ sorted-histogram keys first2 ]
        [ overd index _ nth _ at second + swap - imbalanced ] bi
    ] unless sum + ;

: part-2 ( seq -- n )
    [ [ part-1 ] keep weight ] [ nip weight-needed>> ] recover ;
