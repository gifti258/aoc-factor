using: assocs assocs.extras kernel math.parser math.statistics
sequences sequences.generalizations sets sorting splitting
strings ;
in: 2021.08

! Seven Segment Search
! part 1: number of 1, 4, 7 and 8 digits
! part 2: output value sum

: parse ( seq -- seq' ) [ { "|" } split ] map ;

: part-1 ( seq -- n )
    values [ [ length { 2 3 4 7 } in? ] count ] map-sum ;

constant: digits {
    { "abcefg" char: 0 }
    { "cf" char: 1 }
    { "acdeg" char: 2 }
    { "acdfg" char: 3 }
    { "bcdf" char: 4 }
    { "abdfg" char: 5 }
    { "abdefg" char: 6 }
    { "acf" char: 7 }
    { "abcdefg" char: 8 }
    { "abcdfg" char: 9 }
}

! 1 has 2 segments, 7 has 3 and 4 has 4, all other digits have
! more. The only difference between 1 and 7 is segment a.
! Segments a and c occur 8 times, a is known, the other must be
! c. Segments d and g occur 7 times, the one in digit 4 must be
! d, the other g. Segment e occurs 4 times, b 6 times and f 9
! times.

: part-2 ( seq -- n )
    [
        first2 [
            [ concat histogram ] [
                [ length ] sort-with first3 ! 1 7 4
                [ swap diff first ] dip ! a 4
            ] bi [ '[
                8 7 [ '[ _ = ] filter-values keys ] bi-curry@ bi
                [ _ swap remove first ] [ ! c
                    [ _ intersect first dup ] keep ! d
                    remove first ! g
                ] bi*
            ] [
                4 6 9 [ swap value-at ] tri-curry@ tri ! e b f
            ] bi ] keepd 7 narray "cdgebfa" zip
        ] [
            [ swap substitute natural-sort >string ] with map
            digits substitute dec>
        ] bi*
    ] map-sum ;
