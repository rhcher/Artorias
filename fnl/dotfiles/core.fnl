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

(set vim.o.hidden true)
(set vim.o.updatetime 500)
(set vim.o.clipboard "unnamedplus")

(vim.cmd "filetype plugin on")

(nvim.ex.set :list)
(nvim.ex.set :nowrap)
(nvim.ex.set :noswapfile)
(nvim.ex.set :nobackup)
(nvim.ex.set :number)
(nvim.ex.colorscheme :srcery)
(nvim.ex.set :splitbelow)
(nvim.ex.set :splitright)

;; unused
(vim.cmd "let g:loaded_netrwPlugin = 1")
(vim.cmd "let g:loaded_tarPlugin = 1")
(vim.cmd "let g:loaded_tutor_mode_plugin = 1")
(vim.cmd "let g:loaded_zipPlugin = 1")
(vim.cmd "let g:loaded_gzip = 1")
(vim.cmd "let g:loaded_2html_plugin = 1")
(vim.cmd "let g:loaded_matchit=1")
(vim.cmd "let g:loaded_matchparen=1")

;; Disable unused remote plugin providers
(vim.cmd "let g:loaded_python_provider = 0")
(vim.cmd "let g:loaded_python3_provider = 0")
(vim.cmd "let g:loaded_node_provider = 0")
(vim.cmd "let g:loaded_perl_provider = 0")
(vim.cmd "let g:loaded_ruby_provider = 0")

;; oscyank
(set vim.g.oscyank_silent true)

(vim.cmd "
augroup init
  autocmd!
  autocmd CmdWinEnter * nnoremap <buffer> q <C-W>q
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg \"' | endif
  autocmd TextYankPost * lua vim.highlight.on_yank {higroup='Visual', timeout=150, on_visual=true}
  autocmd BufNewFile * autocmd BufWritePre <buffer> ++once call mkdir(expand('%:h'), 'p')
augroup END")
