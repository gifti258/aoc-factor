USING: arrays assocs assocs.extras combinators grouping.extras
kernel math math.parser multiline peg.ebnf sequences strings ;
IN: 2022.07

! No Space Left On Device
! part 1: sum of directory sizes
! part 2: smallest directory size to free to have unused space
! of at least 30,000,000

SYMBOLS: +cd+ +ls+ +dir+ +file+ ;

EBNF: parse [=[
    n = [0-9]+ => [[ dec> ]]
    str = [a-z./]+ => [[ >string ]]
    cd = "$ cd "~ str => [[ +cd+ 2array ]]
    ls = "$ ls"~ => [[ { +ls+ } ]]
    dir = "dir "~ str => [[ +dir+ 2array ]]
    file = n " "~ str~ => [[ +file+ 2array ]]
    line = cd|ls|dir|file
]=]

: dir-sizes ( seq -- n )
    [ V{ } clone V{ } clone ] dip [
        unclip-last {
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
