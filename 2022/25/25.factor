USING: assocs kernel literals math ranges sequences ;
IN: 2022.25

! Full of Hot Air
! Add a list of balanced quinary numbers

CONSTANT: digits $[ "=-012" -2 2 [a..b] zip ]

: parse ( str -- n ) 0 [ [ 5 * ] dip digits at + ] reduce ;

: part-1 ( seq -- n )
    sum [ 2 + 5 /mod 2 - 2dup [ 0 = ] both? not ]
    [ digits value-at ] "" produce-as 2nip reverse ;
