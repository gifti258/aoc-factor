using: kernel math math.primes.factors sequences ;
in: 2015.20

! Infinite Elves and Infinite Houses
! Find the first house with at least a number of packages
! part 1: each elf delivers 10 presents to house numbers
! divisible by their own number
! part 2: each elf now only delivers to 50 houses, but the
! number of presents is 11 times the house number

: find-n ( n quot -- n )
    [ 0 [ <= ] with ] dip '[ 1 + dup @ ] do until ; inline

: part-1 ( n -- n ) [ divisors sum 10 * ] find-n ;

: part-2 ( n -- n )
    [
        [ divisors ] [ '[ 50 * _ >= ] ] bi filter sum 11 *
    ] find-n ;
