using: 2019.intcode accessors kernel math sequences ;
in: 2019.02

! 1202 Program Alarm
! Introduction of Intcode

: noun/verb ( seq noun/verb -- first )
    100 /mod 1 2 [ pick set-nth ] bi-curry@ bi*
    intcode-state new swap >>memory
    run memory>> 0 swap nth ;

: part-1 ( seq -- n ) 1202 noun/verb ;

: part-2 ( seq -- n )
    10000 <iota>
    [ [ clone ] dip noun/verb 19690720 = ] with find drop ;
