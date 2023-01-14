using: kernel math sequences ;
in: 2017.05

! A Maze of Twisty Trampolines, All Alike
! Number of jumps inside the list

: jump ( seq quot -- n )
    [ 0 swap 0 ] dip '[
        [ 1 + ] 2dip
        2dup swap nth
        [ @ + swap pick set-nth ] [ + ] 2bi
        2dup swap ?nth
    ] loop 2drop ; inline

: part-1 ( seq -- n ) [ 1 ] jump ;

: part-2 ( seq -- n ) [ dup 3 >= -1 1 ? ] jump ;
