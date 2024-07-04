(let [indent (require "ibl")]
  (indent.setup {:scope {:show_start false
                         :show_end false}
                 :exclude {:filetypes ["" "help" "fennel" "packer" "lspinfo" "tsplayground" "query" "scheme"
                                       "racket" "qf" "dashboard" "markdown"]
                           :buftypes ["terminal" "prompt" "toggleterm"]}}))
