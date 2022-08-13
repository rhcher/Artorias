(module dotfiles.plugins_conf
  {require-macros [dotfiles.macros]})

;; srcery
(set vim.g.srcery_italic 1)

;; oscyank
(set vim.g.oscyank_silent true)

;; sandwich plugin
;; (vim.cmd "let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)")
;; (vim.cmd "runtime macros/sandwich/keymap/surround.vim")

;; sexp plugin
(set vim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet,racket")
(set vim.g.sexp_enable_insert_mode_mappings 0)

;; targets plugin
(set vim.g.targets_seekRanges "cc cr cb cB lc ac Ac lr lb ar ab rr rb bb ll al aa")
(set vim.g.targets_separators ", . ; : + - = ~ _ * # / | \\ &")
(set vim.g.targets_argOpening "[({[]")
(set vim.g.targets_argClosing "[]})]")

;; conjure
(set vim.g.conjure#eval#result_register "*")
(set vim.g.conjure#log#botright true)
(set vim.g.conjure#client#scheme#stdio#command "petite")
(set vim.g.conjure#client#scheme#stdio#prompt_pattern "> $?")
(set vim.g.conjure#client#scheme#stdio#value_prefix_pattern false)
(set vim.g.conjure#extract#tree_sitter#enabled true)

;; vim-haskell
(set vim.g.haskell_indent_guard 2)

;; vim-table-mode
(set vim.g.table_mode_corner "|")

;; nvim-gdb
(set vim.g.nvimgdb_use_cmake_to_find_executables 0)
(set vim.g.nvimgdb_config_override {:key_next ";n"
                                    :key_step ";s"
                                    :key_finish ";f"
                                    :key_continue ";c"
                                    :key_until ";u"
                                    :key_breakpoint ";b"})

(let [plugins [:feline :matchparen :neogen :fidget :tabout
               :neoscroll :Comment :possession :nvim-surround]]
  (each [_ plugin (ipairs plugins)]
    (when-let [(_ plug) (pcall require plugin)]
      (plug.setup {}))))

(when-let [(ok? fzf) (pcall require :fzf-lua)]
  (fzf.setup {:winopts {:split "belowright new"
                        :border "single"}}))

(when-let [(_ ufo) (pcall require :ufo)]
  ;; (map :n :<tab> :za)
  (map :n :zR ufo.openAllFolds)
  (map :n :zM ufo.closeAllFolds)
  (ufo.setup))

(when-let [(_ nrpattern) (pcall require :nrpattern)]
  (nrpattern.setup))

(when-let [(_ leap) (pcall require :leap)]
  (leap.set_default_keymaps))
