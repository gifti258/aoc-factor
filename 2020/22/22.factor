USING: arrays kernel math math.order math.parser sequences
vectors ;
IN: 2020.22

! Crab Combat
! Score after card game

: parse ( paragraph1 paragraph2 -- deck1 deck2 )
    [ rest [ dec> ] map >vector ] bi@ ;

: part-1 ( deck1 deck2 -- score )
    [ 2dup [ empty? ] either? ] [
        [ unclip ] bi@ swapd [ 2array ] 2keep before?
        [ reverse append ] [ '[ _ append ] dip ] if
    ] until longer reverse [ 1 + * ] map-index sum ;
