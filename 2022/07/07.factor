using: assocs combinators grouping.extras kernel math
math.parser multiline peg.ebnf sequences strings ;
in: 2022.07

! No Space Left On Device
! part 1: sum of directory sizes
! part 2: smallest directory size to free to have unused space
! of at least 30,000,000

symbols: +cd+ +ls+ +dir+ +file+ ;

ebnf: parse [=[
    n = [0-9]+ => [[ dec> ]]
    str = [a-z./]+ => [[ >string ]]
    cd = "$ cd "~ str:dir => [[ { +cd+ dir } ]]
    ls = "$ ls"~ => [[ { +ls+ } ]]
    dir = "dir "~ str~ => [[ { +dir+ } ]]
    file = n:size " "~ str~ => [[ { +file+ size } ]]
    line = cd|ls|dir|file
]=]

: dir-sizes ( seq -- n )
    [ v{ } clone v{ } clone ] dip [
        unclip {
            { +cd+ [
                first dup ".." =
                [ drop over pop* ] [ pick push ] if
            ] }
            { +ls+ [ drop ] }
            { +dir+ [ drop ] }
            { +file+ [
                first 2over [ head-clump ] dip
                [ [ "/" join ] dip at+ ] curry with each
            ] }
        } case
    ] each nip ;

: part-1 ( seq -- n )
    dir-sizes values [ 100,000 <= ] filter sum ;

: part-2 ( seq -- n )
    dir-sizes
    [ "/" of 40,000,000 - ]
    [ values [ <= ] with filter infimum ] bi ;
