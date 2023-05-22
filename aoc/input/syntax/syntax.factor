USING: combinators definitions effects.parser io.encodings.utf8
io.files io.pathnames kernel macros macros.private namespaces
tools.test.private vocabs.loader vocabs.parser
vocabs.refresh.monitor words ;
IN: aoc.input.syntax

: define-macro* ( word definition effect -- )
    {
        [ nip check-macro-effect ]
        [ [ [ call-effect call ] 2curry ] keep define-declared ]
        [ drop "macro" set-word-prop ]
        [ 2drop t "macro*" set-word-prop ]
        [ 2drop changed-effect ]
    } 3cleave ;

SYNTAX: MACRO*: (:) define-macro* ;

PREDICATE: macro* < macro "macro*" word-prop >boolean ;

M: macro* definer drop \ MACRO*: \ ; ;

: current-path ( -- input-path vocab-name )
    current-test-file get [ parent-directory ] [
        current-vocab vocab-dir vocab-path
    ] if* [ "input" append-path ] keep path>vocab-name ;

SYNTAX: INPUT:
    (:) drop '[
        current-path drop [ utf8 file-lines @ ] curry
    ] ( -- quot ) define-macro* ;
