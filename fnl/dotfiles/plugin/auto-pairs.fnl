(module dotfiles.plugin.auto-pairs
  {autoload {util dotfiles.util}})

(let [pair (require "pairs")
      contain? util.contain?
      language util.lisp-language]
  (pair:setup
    {:enter
     {:enable_cond (fn []
                     (let [filetype (vim.api.nvim_buf_get_option 0 "filetype")]
                       (if (contain? filetype language)
                         false
                         true)))}}))

;; (vim.cmd "let delimitMate_autoclose = 1")
;; (vim.cmd "let delimitMate_expand_cr = 1")
;; (vim.cmd "let delimitMate_excluded_regions = \"String\"")
;; (nvim.ex.autocmd :FileType
;;                  "clojure,fennel,scheme,racket,ocaml"
;;                  "let b:delimitMate_quotes = '\" `'")
