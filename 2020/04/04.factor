USING: aoc.input assocs combinators kernel math.order
math.parser regexp sequences sets sets.extras splitting ;
IN: 2020.04

! Passport Processing
! Count valid passports

<<
: input ( -- seq )
    input-paragraphs
    [ join-words split-words [ ":" split ] map ] map ;
>>

: has-required-fields? ( seq -- ? )
    keys { "byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid" } superset?
    ;

: part-1 ( seq -- n ) [ has-required-fields? ] count ;

: part-2 ( seq -- n )
    [
        [ [ first2 swap {
            { "byr" [ dec> 1920 2002 between? ] }
            { "iyr" [ dec> 2010 2020 between? ] }
            { "eyr" [ dec> 2020 2030 between? ] }
            { "hgt" [ 2 cut* {
                { "cm" [ dec> 150 193 between? ] }
                { "in" [ dec> 59 76 between? ] }
                [ 2drop f ]
            } case ] }
            { "hcl" [ R/ #[0-9a-f]{6}/ matches? ] }
            { "ecl" [ {
                "amb" "blu" "brn" "gry" "grn" "hzl" "oth"
            } in? ] }
            { "pid" [ R/ [0-9]{9}/ matches? ] }
            { "cid" [ drop t ] }
        } case ] all? ] [ has-required-fields? ] bi and
    ] count ;
