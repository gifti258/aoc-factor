USING: accessors assocs combinators deques dlists kernel math
math.parser sequences slots.syntax ;
IN: 2017.18

! Duet
! part 1: first recovered frequency
! part 2: number of values sent by program 1

TUPLE: state program ip registers last-freq ;

: <state> ( seq -- state ) 0 H{ } clone V{ } clone state boa ;

: deref ( str state -- value )
    over dec> [ 2nip ] [ registers>> at ] if* ;

: deref* ( state tuple -- state y x )
    first2 pick '[ _ deref ] bi@ swap ;

: jump ( state y ? -- state' )
    [ '[ _ 1 - + ] change-ip ] [ drop ] if ;

MACRO: change-register ( quot -- quot )
    '[
        first2 pick deref pick registers>>
        [ 0 or swap @ ] with change-at
    ] ;

MACRO: (step) ( snd-quot rcv-quot -- quot )
    '[ unclip {
        { "snd" _ }
        { "set" [ [ nip ] change-register ] }
        { "add" [ [ + ] change-register ] }
        { "mul" [ [ * ] change-register ] }
        { "mod" [ [ mod ] change-register ] }
        { "rcv" _ }
        { "jgz" [ deref* 0 > jump ] }
    } case [ 1 + ] change-ip ] ;

: step ( state instruction -- state' )
    [ first over deref >>last-freq ]
    [ first over deref zero? [ -2 >>ip ] unless ] (step) ;

: run-program ( state -- n )
    [ dup get[ ip program ] ?nth ] [ step ] while*
    last-freq>> ;

: part-1 ( seq -- n ) <state> run-program ;

TUPLE: state* program ip registers inputs outputs n ;

:: <states> ( seq -- state0 state1 )
    <dlist> <dlist> :> ( 0>1 1>0 )
    seq 0 H{ { "p" 0 } } clone 1>0 0>1 0 state* boa
    seq 0 H{ { "p" 1 } } clone 0>1 1>0 0 state* boa ;

: runnable? ( state -- instruction/f )
    [ inputs>> deque-empty? ] [ ip>> ] [ program>> ?nth ] tri
    [ ?first "rcv" = and not ] keep and ;

: step* ( state instruction -- state' )
    [
        first over deref over outputs>> push-front
        [ 1 + ] change-n
    ] [
        first over inputs>> pop-back
        swap pick registers>> set-at
    ] (step) ;

: run-program* ( state -- state' )
    [ dup runnable? ] [ step* ] while* ;

: part-2 ( seq -- n )
    <states> [ over runnable? ] [
        [ run-program* ] bi@
    ] while nip n>> ;
