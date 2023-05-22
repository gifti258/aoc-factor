USING: assocs combinators kernel math math.order math.parser
multiline peg.ebnf sequences sequences.extras strings ;
IN: 2017.08

! I Heard You Like Registers
! part 1: highest register at the end
! part 2: highest register all time

EBNF: parse [=[
    register = [a-z]+ => [[ >string ]]
    n = [-0-9]+ => [[ dec> ]]
    instruction = register " "~ ("inc"|"dec") " "~ n " if "~
        register " "~ ("<="|">="|"=="|"!="|"<"|">") " "~ n
]=]

: process ( instructions -- highest values )
    [ 0 H{ } clone ] dip [
        3 cut overd first3 swap [ of 0 or ] 2dip {
            { "<=" [ <= ] } { ">=" [ >= ] }
            { "==" [ = ] } { "!=" [ = not ] }
            { "<" [ < ] } { ">" [ > ] }
        } case [
            first3 swap "dec" = [ neg ] when swap pick at+
        ] [ drop ] if [ values ?supremum [ max ] when* ] keep
    ] each values supremum ;

: part-1 ( seq -- n ) process nip ;

: part-2 ( seq -- n ) process drop ;
