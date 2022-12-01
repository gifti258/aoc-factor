USING: accessors aoc.md5 assocs assocs.extras grouping
hashtables kernel math math.parser sequences sequences.extras
sets vectors ;
IN: 2016.14

! One-Time Pad
! Find first quintuple 1000 hashes after triplet

TUPLE: state
    { index fixnum }
    { candidates hashtable }
    { keys vector } ;

: find-index ( str quot -- n )
    [
        state new [
            dup index>> 1000 - '[
                [ [ [ _ < ] reject ] call( x -- x ) ] map-values
            ] change-candidates dup [
                candidates>> values [ ?first ] map ?infimum
            ] [
                keys>> 63 swap ?nth
            ] bi [ 2dup and [ > ] [ 2drop f ] if ] keep and dup
        ]
    ] dip '[
        drop 2dup index>> >dec append checksum @ [
            5 clump [ all-equal? ] filter members [
                first over candidates>> [ f ] change-at [
                    '[
                        _ 2dup '[ _ > ] find drop
                        [ over length ] unless* rot insert-nth
                    ] change-keys
                ] each
            ] each
        ] [
            3 clump [ all-equal? ] find nip ?first [
                over [ index>> ] [ candidates>> ] bi
                swapd push-at
            ] when*
        ] bi [ 1 + ] change-index
    ] until 2nip ; inline

: part-1 ( str -- n ) [ ] find-index ;

: part-2 ( str -- n ) [ 2016 [ checksum ] times ] find-index ;
