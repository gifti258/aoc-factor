using: assocs kernel math math.parser math.statistics
multiline peg.ebnf sequences sets sorting strings ;
in: 2016.04

! Security Through Obscurity
! part 1: validate room names, sum sector IDs
! part 2: find sector ID of the room where North Pole objects
! are stored

ebnf: parse [=[
    name = [a-z-]+ => [[ but-last >string ]]
    sector = [0-9]+ => [[ dec> ]]
    checksum = "["~ [a-z]+ "]"~ => [[ >string ]]
    room = name sector checksum
]=]

: checksum ( room -- str )
    first "-" without histogram
    sort-keys reverse sort-values reverse 5 head keys >string ;

: real? ( room -- ? ) [ checksum ] [ third ] bi = ;

: part-1 ( seq -- sum ) [ real? ] filter [ second ] map-sum ;

: decrypt ( room -- str )
    first2 [
        swap
        dup char: - = [ 2drop 32 ] [ 97 - + 26 mod 97 + ] if
    ] curry map ;

: part-2 ( seq -- id )
    [ decrypt "northpole object storage" = ] find nip second ;
