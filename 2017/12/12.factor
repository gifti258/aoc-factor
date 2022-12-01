USING: assocs disjoint-sets kernel math.parser multiline
peg.ebnf sequences sets ;
IN: 2017.12

! Digital Plumber
! part 1: group size of program ID 0
! part 2: number of groups

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    line = n " <-> "~ (n (", "?)~)+
]=]

MEMO: assoc>set ( assoc -- set )
    dup keys <disjoint-set> [ add-atoms ]
    [ '[ swap _ equate-all-with ] assoc-each ] [ ] tri ;

: part-1 ( seq -- n ) assoc>set 0 swap equiv-set-size ;

: part-2 ( seq -- n )
    assoc>set [ disjoint-set-members ] keep
    '[ _ representative ] map cardinality ;
