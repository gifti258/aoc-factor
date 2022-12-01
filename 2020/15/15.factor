USING: assocs hashtables kernel math sequences ;
IN: 2020.15

! Rambunctious Recitation
! Memory game: 0 if last number was new, otherwise number of
! how many turns ago it was said

: nth-number ( seq n -- n )
    [
        [ unclip-last [ zip-index >hashtable ] dip ]
        [ length ] bi
    ] dip '[ dup _ = ] [
        2over of [ dupd - 1 - ] [ 0 ] if*
        [ [ 1 - swap pick set-at ] dip ] keepd 1 +
    ] until drop nip ;

: part-1 ( seq -- n ) 2020 nth-number ;

: part-2 ( seq -- n ) 30,000,000 nth-number ;
