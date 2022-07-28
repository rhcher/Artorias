(module dotfiles.core
  {autoload {nvim aniseed.nvim}
   require-macros [dotfiles.macros]})

;; Generic Neovim configuration.
(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.jumpoptions "stack")
(set nvim.o.pumheight 10)
(set nvim.o.autoindent true)
(set nvim.o.smartindent true)
(set nvim.o.tabstop 2)
(set nvim.o.shiftwidth 2)
(set nvim.o.softtabstop 2)
(set nvim.o.expandtab true)
(set nvim.o.ignorecase true)
(set nvim.o.smartcase true)
(set nvim.o.numberwidth 2)
(set nvim.o.signcolumn "yes")
(set nvim.o.undofile true)
(set nvim.o.scrolloff 4)
(set nvim.o.cursorline true)
(set nvim.o.incsearch false)
(vim.cmd "set diffopt+=internal,algorithm:patience")
(vim.cmd "set fo+=/")

(set vim.o.hidden true)
(set vim.o.updatetime 200)
(set vim.o.clipboard "unnamedplus")
(set vim.opt.laststatus 3)
(set vim.opt.lazyredraw true)
(set vim.opt.relativenumber true)
(set vim.opt.listchars {:nbsp :⦸
                        :extends "»"
                        :precedes "«"
                        :tab :▷⋯
                        :trail :•})
(set vim.o.fillchars "eob: ,fold: ,foldopen:,foldsep: ,foldclose:")
(set vim.o.foldcolumn :1)
(set vim.o.foldlevel 99)
(set vim.o.foldlevelstart -1)
(set vim.o.foldenable true)

(vim.cmd "filetype plugin indent on")

(nvim.ex.set :list)
(nvim.ex.set :nowrap)
(nvim.ex.set :noswapfile)
(nvim.ex.set :nobackup)
(nvim.ex.set :number)
(nvim.ex.set :splitbelow)
(nvim.ex.set :splitright)

(set vim.g.srcery_italic 1)
(vim.cmd.colorscheme :srcery)

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

(set vim.g.clipboard {:name :win32yank-wsl
                      :copy {:+ "win32yank.exe -i --crlf"
                             :* "win32yank.exe -i --crlf"}
                      :paste {:+ "win32yank.exe -o --lf"
                              :* "win32yank.exe -o --lf"}
                      :cache_enable false})

(let [plugins [:feline :matchparen :neogen :fidget
               :neoscroll :Comment :possession :nvim-surround]]
  (each [_ plugin (ipairs plugins)]
    (when-let [(_ plug) (pcall require plugin)]
      (plug.setup {}))))

(when-let [(ok? fzf) (pcall require :fzf-lua)]
  (fzf.setup {:winopts {:split "belowright new"
                        :border "single"}}))

(when-let [(_ ufo) (pcall require :ufo)]
  (map :n :<tab> :za)
  (map :n :zR ufo.openAllFolds)
  (map :n :zM ufo.closeAllFolds)
  (ufo.setup))

(when-let [(_ nrpattern) (pcall require :nrpattern)]
  (nrpattern.setup))

(when-let [(_ leap) (pcall require :leap)]
  (leap.set_default_keymaps))

(when-let [(_ tabout) (pcall require :tabout)]
  (tabout.setup))

(vim.api.nvim_create_augroup "init" {})
(vim.api.nvim_create_autocmd [:CmdWinEnter]
                             {:group "init"
                              :buffer 0
                              :command "cmap q <C-W>q"})
(vim.api.nvim_create_autocmd [:TextYankPost]
                             {:group "init"
                              :callback (fn [] (vim.highlight.on_yank {:higroup "Visual"
                                                                       :timeout 150
                                                                       :on_visual true}))})
(vim.api.nvim_create_autocmd [:BufNewFile]
                             {:group "init"
                              :callback (fn [] (vim.api.nvim_create_autocmd [:BufWritePre]
                                                                            {:once true
                                                                             :buffer 0
                                                                             :command "call mkdir(expand('%:h'), 'p')"}))})

(vim.api.nvim_create_autocmd [:FileType]
                             {:pattern :fennel
                              :callback (. (require :dotfiles.indentation) :fennel_local)})
