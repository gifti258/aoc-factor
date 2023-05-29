USING: kernel math math.parser math.primes ranges sequences ;
IN: 2017.23

: parse ( word-lines -- n ) first last dec> ;

: part-1 ( n -- n ) 2 - sq ;

: part-2 ( n -- n )
    100 * 100,000 + dup 17,000 + 17 <range>
    [ prime? not ] count ;
