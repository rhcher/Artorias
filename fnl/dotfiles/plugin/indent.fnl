; (let [(_ indent) (pcall require "indent_blankline")]
;   (indent.setup {:use_treesitter true
;                  :use_treesitter_scope true
;                  :filetype_exclude ["" "help" "fennel" "packer" "lspinfo" "tsplayground" "query" "scheme"
;                                     "racket" "qf" "dashboard" "markdown" "c" "cpp"]
;                  :buftype_exclude ["terminal" "prompt" "toggleterm"]
;                  :show_trailing_blankline_indent false}))

(let [indent (require "ibl")]
  (indent.setup {:scope {:show_start false
                         :show_end false}
                 :exclude {:filetypes ["" "help" "fennel" "packer" "lspinfo" "tsplayground" "query" "scheme"
                                       "racket" "qf" "dashboard" "markdown" "c" "cpp"]
                           :buftypes ["terminal" "prompt" "toggleterm"]}}))
