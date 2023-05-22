USING: accessors assocs combinators kernel math math.parser
sequences ;
IN: 2016.assembunny

TUPLE: assembunny-state
    program { ip initial: 0 } registers output ;

: <assembunny-state> ( seq -- state )
    assembunny-state new
        H{ { "a" 0 } { "b" 0 } { "c" 0 } { "d" 0 } } clone
        >>registers swap >>program V{ } clone >>output ;

: deref ( state str -- state value )
    dup dec> or* [ over registers>> at ] unless ;

CONSTANT: toggles {
    { "inc" "dec" } { "dec" "inc" } { "tgl" "inc" }
    { "jnz" "cpy" } { "cpy" "jnz" }
}

: (run-program) ( state -- state' )
    [
        dup [ output>> length 12 < ]
        [ ip>> ] [ program>> ?nth and ] tri
    ] [
        unclip {
            { "cpy" [
                [ first deref ] [ second ] bi
                pick registers>> set-at
            ] }
            { "inc" [ first over registers>> inc-at ] }
            { "dec" [ first -1 swap pick registers>> at+ ] }
            { "jnz" [
                [ first deref zero? not ] [ second ] bi swap
                [ deref ] dip
                [ [ 1 - + ] curry change-ip ] [ drop ] if
            ] }
            { "tgl" [
                first deref over [ ip>> + ] [ program>> ] bi
                2dup bounds-check? [
                    [
                        0 over [ toggles at ] change-nth
                    ] change-nth
                ] [ 2drop ] if
            ] }
            { "out" [ first deref over output>> push ] }
        } case [ 1 + ] change-ip
    ] while* ;

: run-program ( state -- a ) (run-program) registers>> "a" of ;

: run-program* ( state -- output ) (run-program) output>> ;
