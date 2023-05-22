USING: kernel sequences sets ;
IN: aoc.assign

: assign ( seq -- seq' )
    [ V{ } clone ] dip [ dup [ empty? ] all?  ] [
        dup [ length 1 = ] find
        [ first swap reach set-nth ] keep '[ _ diff ] map
    ] until drop ;
