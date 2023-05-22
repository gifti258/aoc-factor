USING: assocs disjoint-sets kernel math.combinatorics
math.statistics sequences sets ;
IN: aoc.groups

<PRIVATE

: union-by ( seq quot: ( x y -- ? ) -- representatives )
    [ <disjoint-set> [ add-atoms ] ] dip '[
        [ 2 [ first2 @ ] filter-combinations ] dip
        '[ first2 _ equate ] each
    ] [ '[ _ representative ] map ] 2tri ; inline

PRIVATE>

: count-groups ( seq quot -- n ) union-by cardinality ; inline

: group-sizes ( seq quot -- sizes )
    union-by sorted-histogram values ; inline
