(local lisp-language [:fennel :lisp :scheme :racket :clojure :janet :timl])

(fn contain? [key dict]
  (var result false)
  (each [_ k (ipairs dict)]
    (if (= k key)
      (set result true)))
  result)

{: lisp-language
 : contain?
 : luamap}
