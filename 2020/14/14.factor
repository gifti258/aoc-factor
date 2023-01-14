using: assocs combinators kernel math.combinatorics math.parser
multiline peg.ebnf sequences splitting strings ;
in: 2020.14

! Docking Data
! Sum memory with bitmask applied to data or addresses

ebnf: parse [=[
    mask = "mask = "~ [01X]+ => [[ >string ]]
    n = [0-9]+ => [[ dec> ]]
    mem = "mem["~ n "] = "~ n
    instruction = mask|mem
]=]

: part-1 ( seq -- n )
    [ f h{ } clone ] dip [ {
        { [ dup string? ] [ nipd swap ] }
        [
            first2 >bin 36 char: 0 pad-head
            reach [ dup char: X = [ drop ] [ nip ] if ] 2map
            swap pick set-at
        ]
    } cond ] each nip values [ bin> ] map-sum ;

: part-2 ( seq -- n )
    [ f h{ } clone ] dip [ {
        { [ dup string? ] [ nipd swap ] }
        [
            first2 swap >bin 36 char: 0 pad-head
            reach [ dup char: 0 = [ drop ] [ nip ] if ] 2map
            [ "X" split ] [
                [ char: X = ] count { "0" "1" } swap
                all-selections [ "" suffix ] map
            ] bi [ "" [ 3append ] 2reduce ] with map
            [ pick set-at ] with each
        ]
    } cond ] each nip values sum ;
