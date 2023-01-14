using: assocs kernel math math.statistics sequences
sequences.extras sets splitting unicode ;
in: 2021.12

! Passage Pathing
! part 1: find path from start to end, only pass through small
! caves once
! part 2: one small cave can be passed twice

: parse ( seq -- assoc path )
    h{ } swap [ "-" split ] map
    dup [ reverse ] map append [ pick push-at ] assoc-each
    { "start" } ;

: part-1 ( assoc path -- n )
    dup last pick at over [ lower? ] filter diff [
        dup "end" = [ 3drop 1 ] [ suffix part-1 ] if
    ] 2with map-sum ;

: part-2 ( assoc path -- n )
    dup last pick at { "start" } diff [ suffix ] with [
        [ lower? ] filter histogram values
        [ [ 2 = ] count 1 <= ] [ [ 2 > ] none? ] bi and
    ] map-filter [
        dup last "end" = [ 2drop 1 ] [ part-2 ] if
    ] with map-sum ;
