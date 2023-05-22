USING: aoc.input kernel math math.matrices math.parser sequences
splitting ;
IN: 2021.04

! Giant Squid
! Find the scores of the first and last winning bingo boards

: parse ( seq -- boards numbers )
    unclip
    [ [ split-words harvest [ dec> ] map ] matrix-map ]
    [ first csn-line ] bi* ;

: apply-number ( boards n -- boards' )
    '[ [ [ _ = not ] keep and ] matrix-map ] map ;

: won? ( board -- ? ) dup flip [ [ [ ] none? ] any? ] either? ;

: score ( board n -- n ) [ concat sift sum ] dip * ;

: part-1 ( boards numbers -- n )
    [
        apply-number
        dup [ won? ] find nip [ swap or ] keep
    ] find nip score ;

: part-2 ( boards numbers -- n )
    [
        apply-number
        dup [ length 1 = ] [ [ won? ] find nip ] bi and
        [ or* [ [ won? ] reject ] unless ] keep
    ] find nip score ;
