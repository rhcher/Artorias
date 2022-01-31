(module dotfiles.plugin.auto-pairs
  {autoload {pears pears}})

(let [R (require :pears.rule)]
  (pears.setup
    (fn [c]
      (c.pair "'" {:filetypes {:exclude [:racket :scheme :fennel :lisp]}})
      (c.pair "(" {:close ")"
                   :should_return R.F
                   :filetypes {:exclude [:racket :scheme :fennel :lisp]}})
      (c.remove_pair_on_outer_backspace false))))

; (vim.cmd "let delimitMate_autoclose = 1")
; (vim.cmd "let delimitMate_expand_cr = 1")
; (vim.cmd "let delimitMate_excluded_regions = \"String\"")
; (nvim.ex.autocmd :FileType
;                  "clojure,fennel,scheme,racket,ocaml"
;                  "let b:delimitMate_quotes = '\" `'")
