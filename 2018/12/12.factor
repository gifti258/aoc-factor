USING: arrays assocs assocs.extras grouping kernel math
multiline peg.ebnf ranges sequences ;
IN: 2018.12

! Subterranean Sustainability
! Plant pot number sum after 20/50,000,000,000 generations

EBNF: parse-initial-state [=[
    line = "initial state: "~ [.#]+ => [[ >array ]]
]=]

EBNF: parse-note [=[
    line = [.#]+ => [[ >array ]] " => "~ [.#]
]=]

: parse ( paragraph1 paragraph2 -- str assoc )
    [ first parse-initial-state ] [ [ parse-note ] map ] bi* ;

: part-1 ( str assoc -- n )
    swap 20 [
        "..." [ prepend ] [ append ] bi 5 clump
        over [ at CHAR: . or ] curry map
    ] times nip
    -20 over length 20 - [a..b) zip
    [ CHAR: # = ] filter-keys sum-values ;
