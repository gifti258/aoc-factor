USING: checksums checksums.md5 math.parser ;
IN: aoc.md5

: checksum ( str -- str' ) md5 checksum-bytes bytes>hex-string ;
