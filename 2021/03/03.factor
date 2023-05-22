USING: assocs kernel math math.parser math.statistics sequences
;
IN: 2021.03

! Binary Diagnostic
! part 1: find the most and least used binary digit per column
! part 2: keep numbers with the most or least used digit per
! column until one remains

: part-1 ( seq -- n )
    flip [ sorted-histogram keys ] map flip [ bin> ] map product
    ;

:: bit-criterion ( seq quot -- n )
    0 seq [ dup length 1 = ] quot '[
        over '[ _ swap nth ] collect-by dup
        CHAR: 0 CHAR: 1 [ [ of length ] bi-curry@ bi @ ] most of
        [ 1 + ] dip
    ] until nip first bin> ; inline

: part-2 ( seq -- n )
    [ > ] [ <= ] [ bit-criterion ] bi-curry@ bi * ;
