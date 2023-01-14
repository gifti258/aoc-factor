using: aoc.math.parser arrays grouping kernel math math.vectors
sequences ;
in: 2018.14

! Chocolate Charts
! part 1: get the 10 recipe scores after n recipes
! part 2: number of scores before puzzle input

: update-scoreboard ( v V -- v' V' )
    2dup nths sum >digits append!
    dupd dup dup length '[ nths v+ 1 v+n [ _ mod ] map ] dip ;

: part-1 ( n -- str )
    [ { 0 1 } v{ 3 7 } clone ] dip [ '[ dup length _ 10 + >= ] [
        update-scoreboard
    ] until nip ] [ tail 10 head digits>dec ] bi ;

: part-2 ( str -- n )
    [ { 0 1 } v{ 3 7 } clone ] dip dec>digits '[
        dup 6 <clumps> [ length 2 - ] keep
        [ >array _ = ] find-from drop dup
    ] [ drop update-scoreboard ] until 2nip ;
