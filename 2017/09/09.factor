USING: combinators kernel math sequences ;
IN: 2017.09

! Stream Processing
! part 1: total group score
! part 2: number of non-cancelled characters

: process ( str -- score #characters )
    [ 0 0 0 t t ] dip [ pick [ {
        { CHAR: { [ [ 1 + [ + ] keep ] 3dip ] }
        { CHAR: } [ [ 1 - ] 3dip ] }
        { CHAR: , [ ] }
        { CHAR: < [ [ not ] dip ] }
    } case ] [ over [ {
        { CHAR: > [ [ not ] dip ] }
        { CHAR: ! [ not ] }
        [ drop [ 1 + ] 2dip ]
    } case ] [ drop not ] if ] if ] each 2drop nip ;

: part-1 ( str -- n ) process drop ;

: part-2 ( str -- n ) process nip ;
