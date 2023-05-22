USING: assocs assocs.extras kernel math.order math.parser
multiline peg.ebnf sequences sorting vectors ;
IN: 2016.10

! Balance Bots
! Find the bot that handles the value-17 and value-61 microchips

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    obj = ("bot"|"output") " "~ n
    cmp = obj " gives low to "~ obj " and high to "~ obj
    in = "value "~ n " goes to "~ obj
    rule = cmp|in
]=]

:: run ( seq -- comparisons outputs )
    H{ } clone :> comparisons
    seq [ first vector? ] partition
    [ H{ } clone swap [ unclip pick set-at ] each ]
    [ H{ } clone swap [ first2 pick push-at ] each ] bi*
    :> ( instructions bots )
    [ bots [ length 2 = ] filter-values dup assoc-empty? ] [ [
        natural-sort [ comparisons set-at ] [
            swap [ bots delete-at ] [ instructions at ] bi
            [ bots push-at ] 2each
        ] 2bi
    ] assoc-each ] until drop
    comparisons bots [ first "output" = ] filter-keys ;

: part-1 ( seq -- n ) run drop { 17 61 } of second ;

: part-2 ( seq -- n )
    run nip
    [ second 0 2 between? ] filter-keys values concat product ;
