USING: assocs grouping kernel math sequences ;
IN: 2016.16

! Dragon Checksum

: checksum ( str n -- str )
    tuck '[ dup length _ < ] [
        dup reverse
        [ { { CHAR: 0 CHAR: 1 } { CHAR: 1 CHAR: 0 } } at ] map
        "0" glue
    ] while swap head [ dup length odd? ] [
        2 group [ first2 = CHAR: 1 CHAR: 0 ? ] "" map-as
    ] do until ;

: part-1 ( str -- str ) 272 checksum ;

: part-2 ( str -- str ) 35651584 checksum ;
