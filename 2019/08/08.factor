USING: assocs grouping kernel math sequences ;
IN: 2019.08

! Space Image Format
! part 1: 1/2 digit number product on layer with most 0 digits
! part 2: message after decoding image

: part-1 ( str -- n )
    150 group [ [ CHAR: 0 = ] count ] infimum-by
    [ [ CHAR: 1 = ] count ] [ [ CHAR: 2 = ] count ] bi * ;

: part-2 ( str -- str )
    150 group flip [ [ CHAR: 2 = ] trim-head first ] map
    { { CHAR: 1 CHAR: # } { CHAR: 0 32 } } substitute
    25 group "\n" join ;
