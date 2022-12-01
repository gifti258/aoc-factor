USING: aoc.md5 assocs generalizations kernel math math.parser
sequences sorting strings ;
IN: 2016.05

! How About a Nice Game of Chess?
! Find MD5 hashes starting with 5 zeroes
! part 1: the 6th digit is the next digit of the 8 letter
! password
! part 2: the 6th digit is the position of the 7th digit in the
! password

MEMO: next-hash ( id n -- id n' hash )
    f [
        drop [ 1 + ] 2keep
        >dec append checksum
        dup 5 head [ CHAR: 0 = ] all? not
    ] loop ;

: part-1 ( id -- password )
    0 8 [ next-hash ] replicate 2nip
    [ 5 swap nth ] "" map-as ;

: part-2 ( id -- password )
    H{ } clone swap
    0 [ pick assoc-size 8 = ] [
        next-hash 6 5 [ swap nth ] bi-curry@ bi
        5 npick [ 2dup key? not ] [ drop CHAR: 8 < ] 2bi and
        [ set-at ] [ 3drop ] if
    ] until 2drop sort-keys values >string ;
