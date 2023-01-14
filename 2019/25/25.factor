using: 2019.intcode accessors deques dlists io kernel literals
math math.combinatorics multiline regexp sequences slots.syntax
;
in: 2019.25

! Cryostasis
! Get password for the main airlock

! To adapt to different inputs:
! The word explore-surroundings lets you manually explore your
! surroundings, you then can construct
! find-item-combinations-input and items.
! The word find-item-combination then automatically finds the
! correct combination of items to get into the
! pressure-sensitive floor and get the password for the main
! airlock.

constant: find-item-combinations-input [[ east
east
take semiconductor
north
take planetoid
north
take antenna
south
west
take food ration
north
take space law space brochure
east
take jam
west
north
north
take weather machine
south
south
south
west
west
take monolith
east
east
east
south
east
south
south
east]]

constant: items {
    "semiconductor" "planetoid" "antenna" "food ration"
    "space law space brochure" "monolith" "jam"
    "weather machine"
}

constant: part-1-input [[ east
east
take semiconductor
north
north
take antenna
south
west
take food ration
west
west
take monolith
east
east
east
south
east
south
south
east
east]]

: <ascii> ( -- state )
    intcode-state new
        $[ input-prepare ] clone >>memory
        <dlist> >>inputs
        <dlist> >>outputs ;

: get-output ( state -- state str )
    dup outputs>> "" swap [ suffix ] slurp-deque ;

: print-output ( state -- state ) get-output print flush ;

: feed-input ( state str -- state )
    10 suffix over inputs>> push-all-front ;

: part-1 ( -- str )
    <ascii> part-1-input feed-input run get-output nip
    R/ \d+/ all-matching-subseqs last ;

: run-until-input ( state -- state )
    [
        single-step dup
        [ get[ ip memory ] nth 100 mod 3 = ]
        [ opcode>> 99 = ] bi or not
    ] loop ;

: explore-surroundings ( -- )
    <ascii> [
        run-until-input
        dup opcode>> 99 = not [
            [
                print-output
                readln feed-input
                run-until-output
            ] when
        ] keep
    ] loop drop ;

: single-feed ( state str -- state )
    feed-input run-until-output
    dup opcode>> 99 = [ "program terminated" throw ] when
    run-until-input print-output ;

: find-item-combination ( -- state )
    <ascii> find-item-combinations-input feed-input
    [ single-step dup inputs>> deque-empty? not ] loop
    items all-subsets [
        [
            [ "drop " prepend single-feed ] each
            "inv" single-feed
            "east" single-feed
        ] keep
        [ "take " prepend single-feed ] each
    ] each ;
