USING: assocs combinators kernel make math math.parser multiline
peg.ebnf sequences strings ;
IN: 2015.23

! Opening the Turing Lock
! Assembly interpretation
! part 1: determine value in register b
! part 2: … with register a starting as 1

EBNF: parse [=[
    instruction = [a-z]+ => [[ >string ]]
    register = "a"|"b"
    offset = ("+"|"-") [0-9]+ => [[ concat dec> ]]
    rule = instruction " "~ register? (", "?)~ offset?
]=]

: inc-ip ( ip seq regs offset -- ip' seq regs )
    drop [ 1 + ] 2dip ;

: jump ( ip seq regs offset -- ip' seq regs ) '[ _ + ] 2dip ;

: run ( seq a -- n )
    [ 0 ] 2dip [ "a" ,, 0 "b" ,, ] { } make
    [ 2over ?nth ] [ first3 spin {
        { "hlf" [ pick [ 2/ ] change-at inc-ip ] }
        { "tpl" [ pick [ 3 * ] change-at inc-ip ] }
        { "inc" [ pick inc-at inc-ip ] }
        { "jmp" [ drop jump ] }
        { "jie" [ pick at even? [ jump ] [ inc-ip ] if ] }
        { "jio" [ pick at 1 = [ jump ] [ inc-ip ] if ] }
    } case ] while* 2nip "b" of ;

: part-1 ( seq -- n ) 0 run ;

: part-2 ( seq -- n ) 1 run ;
