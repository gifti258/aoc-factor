using: assocs grouping kernel math sequences ;
in: 2019.08

! Space Image Format
! part 1: 1/2 digit number product on layer with most 0 digits
! part 2: message after decoding image

: part-1 ( str -- n )
    150 group [ [ char: 0 = ] count ] infimum-by
    [ [ char: 1 = ] count ] [ [ char: 2 = ] count ] bi * ;

: part-2 ( str -- str )
    150 group flip [ [ char: 2 = ] trim-head first ] map
    { { char: 1 char: # } { char: 0 32 } } substitute
    25 group "\n" join ;
