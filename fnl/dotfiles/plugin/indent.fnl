(module dotfiles.plugin.indent)

(def- gs
  {:char "│"
   :viewport_buffer 20
   :use_treesitter true
   :show_current_context true
   :context_patterns
   ["class" "function" "method" "^if" "^while" "^for" "^object" "^table"
    "block" "arguments" "^attrset$" "^list$" "^let$" "^indented_string$"]
   :filetype
   ["json" "nix"]
   :filetype_exclude
   ["" "help" "fennel" "packer" "lspinfo" "tsplayground" "query" "scheme" "Trouble"]
   :buftype_exclude
   ["terminal" "prompt" "toggleterm"]})

(def- fennel-gs
  {:char ""
   :context_char "│"
   :filetype ["fennel"]
   :context_patterns
   ["^program$" "^list$" "^sequential_table$" "^table$" "^fn$"
    "^lambda$" "^hashfn$" "^match$" "^let$" "^each$" "^collect$"
    "^icollect$" "^accumulate$" "^for$" "^for_clause$" "^quote$"
    "^iter_bindings$" "^parameters$"]})

(defn normal-mode! []
  (each [k v (pairs gs)]
    (tset vim.g (.. :indent_blankline_ k) v)))

(defn fennel-mode! []
  (each [k v (pairs fennel-gs)]
    (tset vim.g (.. :indent_blankline_ k) v)))

(when-let [(_ indent) (pcall require "indent_blankline")]
  (indent.setup {:use_treesitter true
                 :use_treesitter_scope true
                 :context_patterns ["class" "function" "method" "^if" "^while" "^for" "^object" "^table"
                                    "block" "arguments" "^attrset$" "^list$" "^let$" "^indented_string$"]
                 :filetype_exclude ["" "help" "fennel" "packer" "lspinfo" "tsplayground" "query" "scheme"
                                    "racket" "qf" "dashboard" "markdown"]
                 :buftype_exclude ["terminal" "prompt" "toggleterm"]
                 :show_trailing_blankline_indent false
                 :context_start_priority 90
                 :show_current_context false}))
