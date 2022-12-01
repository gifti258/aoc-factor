USING: assocs combinators generalizations kernel make
math math.parser multiline peg.ebnf sequences strings ;
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

: inc-ip ( ip seq offset -- ip' seq ) drop [ 1 + ] dip ;

: jump ( ip seq offset -- ip' seq ) [ + ] curry dip ;

: run ( instructions a-register -- n )
    [ "a" ,, 0 "b" ,, ] { } make 0 rot
    [ 2dup ?nth ] [ first3 spin {
        { "hlf" [ 5 npick [ 2/ ] change-at inc-ip ] }
        { "tpl" [ 5 npick [ 3 * ] change-at inc-ip ] }
        { "inc" [ 5 npick inc-at inc-ip ] }
        { "jmp" [ drop jump ] }
        { "jie" [ 5 npick at even? [ jump ] [ inc-ip ] if ] }
        { "jio" [ 5 npick at 1 = [ jump ] [ inc-ip ] if ] }
    } case ] while* 2drop "b" of ;

: part-1 ( seq -- n ) 0 run ;

: part-2 ( seq -- n ) 1 run ;
