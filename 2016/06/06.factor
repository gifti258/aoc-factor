using: assocs kernel math.statistics sequences ;
in: 2016.06

! Signals and Noise
! Find the most/least used character in each column

: columns ( seq quot -- str )
    [ flip ] dip '[ sorted-histogram keys @ ] "" map-as ; inline

: part-1 ( seq -- str ) [ last ] columns ;

: part-2 ( seq -- str ) [ first ] columns ;
