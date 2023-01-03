using: assocs grouping kernel math sequences ;
in: 2016.16

! Dragon Checksum

: checksum ( str n -- str )
    tuck '[ dup length _ < ] [
        dup reverse
        [ { { char: 0 char: 1 } { char: 1 char: 0 } } at ] map
        "0" glue
    ] while swap head [ dup length odd? ] [
        2 <groups> [ first2 = char: 1 char: 0 ? ] "" map-as
    ] do until ;

: part-1 ( str -- str ) 272 checksum ;

: part-2 ( str -- str ) 35651584 checksum ;
