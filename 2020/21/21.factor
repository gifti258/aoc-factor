USING: aoc.assign assocs assocs.extras kernel multiline peg.ebnf
sequences sets sorting strings ;
IN: 2020.21

! Allergen Assessment
! part 1: count non-unique non-allergenic ingredients
! part 2: alphabetical list of allergenic ingredients

EBNF: parse [=[
    word = [a-z]+ => [[ >string ]]
    ingredients = (word " "~)+
    allergens = "(contains "~ (word (", "?)~)+ ")"~
    line = ingredients allergens
]=]

: allergenic-ingredients ( assoc -- seq )
    [ values union-all natural-sort ] keep '[
        _ [ in? ] with filter-values keys intersect-all
    ] map ;

: part-1 ( assoc -- n )
    [ keys ] [ allergenic-ingredients union-all ] bi '[
        _ without
    ] map sum-lengths ;

: part-2 ( assoc -- str )
    allergenic-ingredients assign "," join ;
