;; extends
((symbol) @include
          (#any-of? @include
           "require" "require-macros" "import-macros" "include"))


((symbol) @function.macro
          (#any-of? @function.macro
           "->" "->>" "-?>" "-?>>" "?." "doto" "macro" "macrodebug" "partial" "pick-args"
           "pick-values" "with-open" "module"))

; ((symbol) @include
;           (#any-of? @include
;            "autoload")
;           (set! "priority" 1000))

((list .
   (symbol) @keyword.function .
   (symbol) @function)
 (#any-of? @keyword.function "defn" "defn-"))

((list .
   (symbol) @keyword)
 (#any-of? @keyword "def" "def-" "when-let" "if-let" "defonce" "defonce-"))

((symbol) @include (#eq? @include "autoload"))
