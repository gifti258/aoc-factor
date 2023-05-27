USING: arrays combinators kernel math math.parser
math.primes.factors multiline peg.ebnf sequences
sequences.extras strings ;
IN: 2018.19

! Go With The Flow
! Register 0 value after program halts
! Calculate sum of divisors after initialization

EBNF: parse [=[
    declaration = "#ip "~ n
    opcode = .... => [[ >string ]]
    n = [0-9]+ => [[ dec> ]]
    instruction = opcode " "~ n " "~ n " "~ n
    line = declaration|instruction
]=]

: prepare ( program -- ipreg registers program' )
    unclip swap 6 0 <array> swap ;

: instruction ( args registers quot quot: ( a b -- c ) -- )
    [ 2dup ] 2dip '[ [ first2 ] [ '[ _ nth ] @ @ ] bi* ]
    [ [ third ] [ set-nth ] bi* ] 2bi* ; inline

: step ( ipreg registers program -- ipreg registers' program )
    3dup [ [ [ nth ] bi@ unclip ] keepd swap {
        { "addr" [ [ bi@ ] [ + ] instruction ] }
        { "addi" [ [ dip ] [ + ] instruction ] }
        { "mulr" [ [ bi@ ] [ * ] instruction ] }
        { "muli" [ [ dip ] [ * ] instruction ] }
        { "banr" [ [ bi@ ] [ bitand ] instruction ] }
        { "bani" [ [ dip ] [ bitand ] instruction ] }
        { "borr" [ [ bi@ ] [ bitor ] instruction ] }
        { "bori" [ [ dip ] [ bitor ] instruction ] }
        { "setr" [ [ dip ] [ drop ] instruction ] }
        { "seti" [ [ drop ] [ drop ] instruction ] }
        { "gtir" [ [ call ] [ > 1 0 ? ] instruction ] }
        { "gtri" [ [ dip ] [ > 1 0 ? ] instruction ] }
        { "gtrr" [ [ bi@ ] [ > 1 0 ? ] instruction ] }
        { "eqir" [ [ call ] [ = 1 0 ? ] instruction ] }
        { "eqri" [ [ dip ] [ = 1 0 ? ] instruction ] }
        { "eqrr" [ [ bi@ ] [ = 1 0 ? ] instruction ] }
    } case ] 2keepd [ 1 + ] change-nth ;

: run ( ipreg registers program -- n )
    [ 2over nth 1 = ] [ step ] until
    4 nth-of third nth-of nip divisors sum ;

: part-1 ( program -- n ) prepare run ;

: part-2 ( program -- n ) prepare 1 0 reach set-nth run ; 
