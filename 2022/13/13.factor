using: combinators kernel math math.matrices math.order
math.parser math.vectors multiline peg.ebnf sequences sorting
vectors ;
in: 2022.13

! Distress Signal
! part 1: sum of indices of pairs in right order
! part 2: insert divider packets, sort and find product of
! indices of divider packets

ebnf: (parse) [=[
    n = [0-9]+ => [[ dec> ]]
    list = "["~ ((list|n) (","?)~)* "]"~
]=]

: parse ( seq -- seq' ) [ (parse) ] matrix-map ;

defer: compare
: (compare) ( seq1 seq2 -- <f> )
    [ f ] 2dip 2dup [ length ] bi@ max [
        [ [ swap ?nth ] curry bi@ compare or ] 2keepd
    ] each-integer 2drop ;

: compare ( item1 item2 -- <f> )
    {
        { [ over not ] [ 2drop +lt+ ] }
        { [ dup not ] [ 2drop +gt+ ] }
        { [ 2dup [ number? ] both? ] [
            <=> [ +eq+ = not ] keep and
        ] }
        { [ 2dup [ sequence? ] both? ] [ (compare) ] }
        [ [ dup number? [ 1vector ] when ] bi@ compare ]
    } cond ;

: part-1 ( seq -- n )
    [ [ first2 compare +lt+ = ] dip and ] map-index sift 1 v+n
    sum ;

: part-2 ( seq -- n )
    concat { { { 2 } } { { 6 } } }
    [ append [ compare +eq+ or ] sort ]
    [ swap '[ _ index ] map 1 v+n product ] bi ;
