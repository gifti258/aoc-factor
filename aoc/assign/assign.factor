using: kernel sequences sets ;
in: aoc.assign

: assign ( seq -- seq' )
    [ v{ } clone ] dip [ dup [ empty? ] all?  ] [
        dup [ length 1 = ] find
        [ first swap reach set-nth ] keep '[ _ diff ] map
    ] until drop ;
