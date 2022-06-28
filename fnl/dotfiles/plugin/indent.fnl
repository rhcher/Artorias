(module dotfiles.plugin.indent
  {autoload {:indent :indent_blankline}})

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

(indent.setup {:use_treesitter true
               :context_patterns ["class" "function" "method" "^if" "^while" "^for" "^object" "^table"
                                  "block" "arguments" "^attrset$" "^list$" "^let$" "^indented_string$"]
               :filetype_exclude ["" "help" "fennel" "packer" "lspinfo" "tsplayground" "query" "scheme" "Trouble"]
               :buftype_exclude ["terminal" "prompt" "toggleterm"]
               :show_current_context true
               :show_current_context true})
