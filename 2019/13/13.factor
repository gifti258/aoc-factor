using: 2019.intcode accessors arrays assocs assocs.extras
continuations deques dlists kernel math sequences ;
in: 2019.13

! Care Package
! part 1: count block tiles
! part 2: score after playing the game

: run-until-output* ( assoc state -- assoc state )
    [ run-until-output ] [
        drop over 4 3 [ = ] bi-curry@
        [ filter-values keys first first ] bi-curry@ bi -
        1dlist >>inputs run-until-output
    ] recover ;

: draw ( seq -- assoc )
    intcode-state new
        swap >>memory
        <dlist> >>outputs
    h{ } clone swap [
        run-until-output*
        dup opcode>> 99 =
    ] [
        dup outputs>> pop-back
        over run-until-output* outputs>> pop-back 2array
        over run-until-output* outputs>> pop-back
        swap reach set-at
    ] until drop ;

: part-1 ( seq -- n ) draw [ 2 = ] filter-values assoc-size ;

: part-2 ( seq -- n ) 2 0 pick set-nth draw { -1 0 } of ;
