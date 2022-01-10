(module dotfiles.core
  {autoload {nvim aniseed.nvim}})

;; Generic Neovim configuration.
(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.jumpoptions "stack")
(set nvim.o.pumheight 10)
(set nvim.o.autoindent true)
(set nvim.o.tabstop 2)
(set nvim.o.shiftwidth 2)
(set nvim.o.softtabstop 2)
(set nvim.o.expandtab true)
(set nvim.o.ignorecase true)
(set nvim.o.smartcase true)
(set nvim.o.smartindent true)
(set nvim.o.numberwidth 2)
(set nvim.o.signcolumn "yes")
(set nvim.o.undofile true)
(set nvim.o.scrolloff 4)
(set nvim.o.cursorline true)

(set vim.o.hidden true)
(set vim.o.updatetime 500)
(set vim.o.clipboard "unnamedplus")

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

(vim.cmd "
augroup init
  autocmd!
  autocmd CmdWinEnter * nnoremap <buffer> q <C-W>q
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg *' | endif
  autocmd TextYankPost * lua vim.highlight.on_yank {higroup='Visual', timeout=150, on_visual=true}
  autocmd BufNewFile * autocmd BufWritePre <buffer> ++once call mkdir(expand('%:h'), 'p')
augroup END")
