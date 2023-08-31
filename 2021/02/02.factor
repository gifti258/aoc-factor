USING: combinators kernel math math.parser multiline sequences ;
IN: 2021.02

! Dive!
! Multiply coordinates of end position

: part-1 ( seq -- n )
    [ 0 0 ] dip (( pos depth )) [ first2 dec> swap {
        { "forward" [ '[ _ + ] dip ] }
        { "up" [ - ] }
        { "down" [ + ] }
    } case ] each * ;

: part-2 ( seq -- n )
    [ 0 0 0 ] dip (( pos depth aim )) [ first2 dec> swap {
        { "forward" [ [ '[ _ + ] 2dip ] [ [ * + ] keepd ] bi ] }
        { "up" [ - ] }
        { "down" [ + ] }
    } case ] each drop * ;
