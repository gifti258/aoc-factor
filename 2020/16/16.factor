using: aoc.input assocs assocs.extras kernel math.order
math.parser multiline peg.ebnf sequences sets strings ;
in: 2020.16

! Ticket Translation
! part 1: Sum of ticket fields that aren't valid for any field
! part 2: Product of ticket fields whose names begin with
! “departure”

ebnf: field [=[
    n = [0-9]+ => [[ dec> ]]
    str = [^:]+ => [[ >string ]]
    range = n "-"~ n
    ranges = (range (" or "?)~)+
    field = str ": "~ ranges
]=]

: parse ( paragraphs -- fields ticket tickets )
    first3
    [ [ field ] map ]
    [ second csn-line ]
    [ rest [ csn-line ] map ] tri* ;

:: part-1 ( fields ticket tickets -- n )
    tickets concat
    fields values concat
    '[ _ [ first2 between? ] with none? ] filter sum ;

: filter-tickets ( tickets fields -- tickets' )
    values concat '[
        [ _ [ first2 between? ] with any? ] all?
    ] filter ;

: find-candidates ( columns fields -- candidates-seq )
    '[
        [
            _ [
                [ first2 between? ] with any?
            ] with filter-values keys
        ] map intersect-all
    ] map ;

: assign-candidates ( candidates-seq -- candidates )
    [ v{ } clone ] dip [ dup [ empty? ] all?  ] [
        dup [ length 1 = ] find
        [ first swap reach set-nth ] keep '[ _ diff ] map
    ] until drop ;

: part-2 ( fields ticket tickets -- n )
    -rot [
        [ filter-tickets flip ] keep find-candidates
        assign-candidates zip-index
        [ "departure" head? ] filter-keys values
    ] [ nths product ] bi* ;
