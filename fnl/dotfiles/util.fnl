(local lisp-language [:fennel :lisp :scheme :racket :clojure :janet :timl])
(local treesitter-language [:c :cpp :rust :lua :python :cmake :markdown :markdown_inline
                            :vim :fennel :query :ocaml :ocaml_interface :haskell :scheme
                            :regex :bash :luap :racket :html])

(fn contain? [key dict]
  (var result false)
  (each [_ k (ipairs dict)]
    (if (= k key)
      (set result true)))
  result)

{: lisp-language
 : treesitter-language
 : contain?}
