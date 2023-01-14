using: combinators kernel math sequences ;
in: 2017.09

! Stream Processing
! part 1: total group score
! part 2: number of non-cancelled characters

: process ( str -- score #characters )
    [ 0 0 0 t t ] dip [ pick [ {
        { char: { [ [ 1 + [ + ] keep ] 3dip ] }
        { char: } [ [ 1 - ] 3dip ] }
        { char: , [ ] }
        { char: < [ [ not ] dip ] }
    } case ] [ over [ {
        { char: > [ [ not ] dip ] }
        { char: ! [ not ] }
        [ drop [ 1 + ] 2dip ]
    } case ] [ drop not ] if ] if ] each 2drop nip ;

: part-1 ( str -- n ) process drop ;

: part-2 ( str -- n ) process nip ;
