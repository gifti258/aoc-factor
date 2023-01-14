using: arrays assocs assocs.extras biassocs kernel math
math.vectors sequences sequences.extras sets ;
in: 2022.17

! Pyroclastic Flow
! Tower height after 2022/1,000,000,000,000 rocks

constant: shapes {
    { { 0 0 } { 1 0 } { 2 0 } { 3 0 } }
    { { 0 1 } { 1 0 } { 1 1 } { 1 2 } { 2 1 } }
    { { 0 0 } { 1 0 } { 2 0 } { 2 1 } { 2 2 } }
    { { 0 0 } { 0 1 } { 0 2 } { 0 3 } }
    { { 0 0 } { 0 1 } { 1 0 } { 1 1 } }
}

: height ( set -- n )
    members values ?supremum [ 1 + ] [ 0 ] if* ;

macro: ?move ( map cond -- quot: ( st fa -- st fa' ? ) )
    '[ dup _ map
    dup [ reach intersects? ] _ bi or
    [ [ drop ] [ nip ] if ] keep not ] ;

: rock ( jet jets shape stopped -- jet' jets shape' stopped' )
        2dup [ shapes nth ]
        [ height 3 + '[ { 2 _ } v+ ] map ] bi*
        [ 1 + 5 mod ] 2dip [
            [ 2dup nth ] 3dip roll char: < = [
                [ { 1 0 } v- ] [ keys infimum 0 < ] ?move drop
            ] [
                [ { 1 0 } v+ ] [ keys supremum 6 > ] ?move drop
            ] if [ [ 1 + ] dip [ length mod ] keep ] 3dip
            [ { 0 1 } v- ] [ values infimum -1 = ] ?move
        ] loop union! ;

: part-1 ( jets -- n )
    0 swap 0 hs{ } clone 2022 [ rock ] times 3nip height ;

: relative-heights ( set -- seq )
    members 7 <iota> [
        '[ _ = ] filter-keys values ?supremum
    ] with map dup ?infimum '[
        _ 2dup [ not ] either? [ and ] [ - ] if
    ] map ;

:: part-2 ( jets -- n )
    <bihash> 0 0 0 hs{ } clone :> ( cache n! jet shape stopped )
    jet jets shape stopped [
        rock n 1 + n! reach pick :> ( jet shape )
        n stopped [ height 2array ]
        [ relative-heights ] bi jet shape 3array
        cache 2dup at dup
    ] [
        [ 3drop ] [ set-at ] if
    ] until :> ( v' k cache v ) 4drop
    v first v' v v- first2 :> ( n dn dh )
    1,000,000,000,000 n -
    [ dn /i dh * ] [ dn mod n + cache values at ] bi + ;
