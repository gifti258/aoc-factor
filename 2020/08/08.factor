USING: accessors assocs combinators continuations
kernel math math.parser multiline peg.ebnf sequences
sequences.extras sets ;
IN: 2020.08

! Handheld Halting
! part 1: accumulator before first instruction executed twice
! part 2: accumulator at the end of repaired program

EBNF: parse [=[
    operation = "acc"|"jmp"|"nop"
    argument = [-+0-9]+ => [[ dec> ]]
    instruction = operation " "~ argument
]=]

ERROR: infinite-loop n ;

: run ( seq -- n )
    [ 0 f 0 ] dip [
        2dup length =
    ] [
        2over swap in? [ 3drop infinite-loop ] when
        [ [ suffix ] keep ] dip
        2dup nth first2 swap {
            { "acc" [ '[ _ + ] 3dip [ 1 + ] dip ] }
            { "jmp" [ '[ _ + ] dip ] }
            { "nop" [ drop [ 1 + ] dip ] }
        } case
    ] until 3drop ; inline

: part-1 ( seq -- n ) [ run ] [ nip n>> ] recover ;

: part-2 ( seq -- n )
    [ [ first { "nop" "jmp" } in? ] find-all keys ] keep '[
        _ [ clone ] map [ [
            0 over [ "jmp" = "nop" "jmp" ? ] change-nth
        ] change-nth ] keep
    ] map [ [ run ] [ 2drop f ] recover ] map-find drop ;
