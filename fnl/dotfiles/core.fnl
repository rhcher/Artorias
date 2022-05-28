(module dotfiles.core
  {autoload {nvim aniseed.nvim}})

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
(set vim.opt.foldmethod "expr")
(set vim.opt.foldexpr "nvim_treesitter#foldexpr()")
(set vim.opt.foldenable false)

(vim.cmd "filetype plugin on")

(nvim.ex.set :list)
(nvim.ex.set :nowrap)
(nvim.ex.set :noswapfile)
(nvim.ex.set :nobackup)
(nvim.ex.set :number)
(nvim.ex.set :splitbelow)
(nvim.ex.set :splitright)

(set vim.g.srcery_italic 1)
(nvim.ex.colorscheme :srcery)

;; oscyank
(set vim.g.oscyank_silent true)

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
