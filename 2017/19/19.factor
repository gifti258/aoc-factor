USING: arrays combinators.extras generalizations kernel
math.matrices math.vectors sequences ;
IN: 2017.19

! A Series of Tubes
! part 1: letters on the path
! part 2: number of steps

: ?next-loc ( m p c v -- m p c v n/f )
    2dup v+ 5 npick dupd matrix-nth 32 = not swap and ;

: accept ( m p c v n -- m c n t ) nip nipd t ;

MEMO: path ( seq -- str )
    f swap dup first CHAR: | swap index 0 swap 2array
    [ { -1 0 } v+ ] keep [
        pick dupd matrix-nth [ suffix ] curry 3dip
        2dup swap v- {
            { [ ?next-loc ] [ accept ] }
            { [ reverse ?next-loc ] [ accept ] }
            { [ vneg ?next-loc ] [ accept ] }
            [ drop f ]
        } cond*
    ] loop 3drop ;

: part-1 ( seq -- str ) path [ "+-|" member? ] "" reject-as ;

: part-2 ( seq -- n ) path length ;
