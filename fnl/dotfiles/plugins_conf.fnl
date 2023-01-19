(module dotfiles.plugins_conf
  {require-macros [dotfiles.macros]})

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
(if (= (. (vim.fs.find "nvim" {:upward true}) 1)
       (vim.fn.stdpath "config"))
  (do
    (set vim.g.conjure#mapping#doc_word false)
    (set vim.g.conjure#filetype#fennel "conjure.client.fennel.aniseed"))
  (set vim.g.conjure#filetype#fennel "conjure.client.fennel.stdio"))

(set vim.g.conjure#client#scheme#stdio#value_prefix_pattern false)

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

(let [plugins [:feline :matchparen :fidget :tabout
               :neoscroll :Comment :hlslens]]
  (each [_ plugin (ipairs plugins)]
    (when-let [(_ plug) (pcall require plugin)]
      (plug.setup {}))))

(when-let [(_ surround) (pcall require :nvim-surround)]
  (surround.setup {:surrounds {"(" {:add ["(" ")"]}
                               ")" {:add ["( " " )"]}
                               "{" {:add ["{" "}"]}
                               "}" {:add ["{ " " }"]}
                               "[" {:add ["[" "]"]}
                               "]" {:add ["[ " " ]"]}}
                   :move_cursor false}))

(when-let [(_ fzf) (pcall require :fzf-lua)]
  (fzf.setup {:winopts {:split "bot new"
                        :border "single"}})
  (map :n :<leader>ff fzf.files)
  (map :n :<leader>fp #(fzf.files {:cwd "~/.config/nvim/"}))
  (map :n :<leader>fs fzf.live_grep_native)
  (map :n :<leader>fb fzf.buffers)
  (map :n :<leader>bb fzf.buffers)
  (map :n :<leader>fh fzf.help_tags)
  (map :n :<leader>fk fzf.keymaps)
  (map :n :<leader>fl fzf.blines)
  (map :n :<leader>pl fzf.lines)
  (map :n :<leader>fo fzf.oldfiles)
  (map :n :<leader>fc fzf.commands)
  (map :n :<leader>fq fzf.quickfix)
  (map :n :<leader>fg fzf.git_bcommits))

(when-let [(_ ufo) (pcall require :ufo)]
  ;; (map :n :<tab> :za)
  (map :n :zR ufo.openAllFolds)
  (map :n :zM ufo.closeAllFolds)
  (local ftmap
    {:vim "indent"
     :fennel "treesitter"
     :python "indent"
     :git ""})
  (ufo.setup {:provider_selector (fn [bufnr filetype buftype]
                                   (. ftmap filetype))}))

(when-let [(_ nrpattern) (pcall require :nrpattern)]
  (nrpattern.setup))

(when-let [(_ leap) (pcall require :leap)]
  (leap.set_default_keymaps))

(when-let [(_ illuminate) (pcall require :illuminate)]
  (illuminate.configure {:providers [:lsp :regex]
                         :modes_denylist [:i]
                         :large_file_cutoff 10000
                         :large_file_overrides nil}))

(when-let [(_ neogen) (pcall require :neogen)]
  (neogen.setup {:snippet_engine :snippy}))
