USING: combinators effects.parser io.encodings.utf8 io.files
io.pathnames kernel macros.private namespaces tools.test.private
vocabs vocabs.loader vocabs.parser vocabs.refresh.monitor words
;
IN: aoc.input.syntax

: define-macro* ( word definition effect -- )
    {
        [ nip check-macro-effect ]
        [ [ [ call-effect call ] 2curry ] keep define-declared ]
        [ drop "macro" set-word-prop ]
        [ 2drop changed-effect ]
    } 3cleave ;

SYNTAX: MACRO*: (:) define-macro* ;

: current-path ( -- input-path vocab-name )
    current-test-file get [ parent-directory ] [
        current-vocab vocab-dir vocab-path
    ] if* [ "input" append-path ] keep path>vocab-name ;

SYNTAX: INPUT:
    (:) drop '[
        current-path drop [ utf8 file-lines @ ] curry
    ] ( -- quot ) define-macro* ;
