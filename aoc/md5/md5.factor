using: checksums checksums.md5 math.parser ;
in: aoc.md5

: checksum ( str -- str' ) md5 checksum-bytes bytes>hex-string ;
