using: assocs hashtables json.reader kernel math sequences
sequences.deep ;
in: 2015.12

! JSAbacusFramework.io
! Sum all numbers in a json

: tally ( json quot -- n )
    [ json> ] dip '[ dup hashtable? [ >alist @ ] when ] deep-map
    0 [ dup number? [ + ] [ drop ] if ] deep-reduce ; inline

: part-1 ( json -- n ) [ ] tally ;

: part-2 ( json -- n )
    [ concat dup [ "red" = ] any? [ drop 0 ] when ] tally ;
