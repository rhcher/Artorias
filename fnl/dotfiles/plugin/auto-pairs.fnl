(module dotfiles.plugin.auto-pairs
  {autoload {pair pairs}})

(pair:setup
  {:enter
   {:enable_cond (fn []
                   (let [filetype (vim.api.nvim_buf_get_option 0 "filetype")]
                     (if (or (= filetype "fennel")
                             (= filetype "lisp")
                             (= filetype "scheme")
                             (= filetype "racket"))
                       false
                       true)))}})

; (let [R (require :pears.rule)
;       pears (require "pears")]
;   (pears.setup
;     (fn [c]
;       (c.pair "'" {:filetypes {:exclude [:racket :scheme :fennel :lisp]}})
;       ; (c.pair "(" {:close ")"
;       ;              :should_return R.F
;       ;              :filetypes {:exclude [:racket :scheme :fennel :lisp]}})
;       (c.remove_pair_on_outer_backspace false))))

; (vim.cmd "let delimitMate_autoclose = 1")
; (vim.cmd "let delimitMate_expand_cr = 1")
; (vim.cmd "let delimitMate_excluded_regions = \"String\"")
; (nvim.ex.autocmd :FileType
;                  "clojure,fennel,scheme,racket,ocaml"
;                  "let b:delimitMate_quotes = '\" `'")
