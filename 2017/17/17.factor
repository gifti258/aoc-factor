USING: kernel math sequences ;
IN: 2017.17

! Spinlock

: part-1 ( n -- n )
    1 0 { 0 } 2017 [
        [ pick + ] dip [ length ] keep [ mod 1 + ] dip
        [ 2dup ] dip insert-nth [ 1 + ] 2dip
    ] times [ 1 + ] dip nth 2nip ;

: part-2 ( n -- seq )
    1 0 1 f 50,000,000 [
        [ pick + ] 2dip [ [ mod 1 + ] keep ] dip
        pick 1 = [ drop pick ] when [ 1 + ] 3dip [ 1 + ] dip
    ] times 4nip ;
