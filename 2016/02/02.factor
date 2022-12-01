USING: assocs kernel multiline sequences ;
IN: 2016.02

! Bathroom Security
! Find the keypad code for the bathroom

! assocs that map between previous key and next key
! arrays are in the order left-right-up-down

/*
1 2 3
4 5 6
7 8 9
*/

CONSTANT: pad-1 H{
    { "1" { "1" "2" "1" "4" } }
    { "2" { "1" "3" "2" "5" } }
    { "3" { "2" "3" "3" "6" } }
    { "4" { "4" "5" "1" "7" } }
    { "5" { "4" "6" "2" "8" } }
    { "6" { "5" "6" "3" "9" } }
    { "7" { "7" "8" "4" "7" } }
    { "8" { "7" "9" "5" "8" } }
    { "9" { "8" "9" "6" "9" } }
}

/*
    1
  2 3 4
5 6 7 8 9
  A B C
    D
*/

CONSTANT: pad-2 H{
    { "1" { "1" "1" "1" "3" } }
    { "2" { "2" "3" "2" "6" } }
    { "3" { "2" "4" "1" "7" } }
    { "4" { "3" "4" "4" "8" } }
    { "5" { "5" "6" "5" "5" } }
    { "6" { "5" "7" "2" "A" } }
    { "7" { "6" "8" "3" "B" } }
    { "8" { "7" "9" "4" "C" } }
    { "9" { "8" "9" "9" "9" } }
    { "A" { "A" "B" "6" "A" } }
    { "B" { "A" "C" "7" "D" } }
    { "C" { "B" "C" "8" "C" } }
    { "D" { "D" "D" "B" "D" } }
}

: code ( seq pad -- str )
    [ "5" ] 2dip [
        [ swapd at [ "LRUD" index ] [ nth ] bi* ] curry each dup
    ] curry map nip concat ;

: part-1 ( seq -- str ) pad-1 code ;

: part-2 ( seq -- str ) pad-2 code ;
