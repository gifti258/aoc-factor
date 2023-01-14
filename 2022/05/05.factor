using: kernel math math.parser math.vectors multiline peg.ebnf
sequences vectors ;
in: 2022.05

! Supply stacks
! Crates on top of the stacks
! part 1: move stacks crate by crate
! part 2: move stacks whole

ebnf: parse-layer [=[
    empty = "   "~ (" "?)~ => [[ f ]]
    crate = "["~ . "]"~ (" "?)~
    layer = (crate|empty)+
]=]

ebnf: parse-move [=[
    n = [0-9]+ => [[ dec> ]]
    move = "move "~ n " from "~ n " to "~ n
]=]

: parse ( paragraph1 paragraph2 -- stacks moves )
    [
        but-last reverse [ parse-layer ] map flip
        [ sift >vector ] map
    ] [ [ parse-move ] map ] bi* ;

: skim ( vectors -- str ) [ last ] "" map-as ;

: part-1 ( stacks moves -- elts )
    [
        unclip swap 1 v-n '[
            _ over nths first2 [ pop ] dip push
        ] times
    ] each skim ;

: part-2 ( stacks moves -- elts )
    [
        first3 [ 1 - ] bi@
        spin [ pick 2dup nth ] dip cut*
        [ -rot set-nth ] [ '[ _ append ] overd change-nth ] bi*
    ] each skim ;
