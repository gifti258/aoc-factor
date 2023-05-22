USING: kernel math sequences ;
IN: 2019.01

! The Tyranny of the Rocket Equation
! Calculate the fuel needed for the rocket

: mass>fuel ( mass -- fuel ) 3 /i 2 - ;

: part-1 ( seq -- n ) [ mass>fuel ] map-sum ;

: mass>fuel* ( mass -- fuel )
    mass>fuel dup neg? [ drop 0 ] [ dup mass>fuel* + ] if ;

: part-2 ( seq -- n ) [ mass>fuel* ] map-sum ;
