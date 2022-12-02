USE: combinators.smart
IN: aoc.combinators.smart

: sequence>sequence ( seq quot exemplar -- new-seq )
    '[ _ _ output>sequence ] input<sequence ; inline

: sequence>array ( seq quot -- array )
    { } sequence>sequence ; inline
