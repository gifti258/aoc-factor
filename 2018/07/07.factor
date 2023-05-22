USING: assocs assocs.extras kernel multiline peg.ebnf
sequences sequences.extras sets strings ;
IN: 2018.07

! The Sum of Its Parts
! part 1: order steps
! part 2: number of minutes to complete steps with 5 people

EBNF: parse [=[
    step = [A-Z]
    instruction = "Step "~ step
        " must be finished before step "~ step " can begin."~
]=]

: part-1 ( seq -- str )
    V{ } clone dup clone pick unzip diff over push-all [
        [ infimum dup ] keep [ [ suffix ] 2dip remove ] keepd
        reach [ = ] with filter-keys values [
            [ pick ] dip [ = ] curry filter-values keys
            pick diff empty?
        ] filter over push-all
    ] until-empty nip >string ;
