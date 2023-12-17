(import-macros {: augroup} "dotfiles.macros")

;; Generic Neovim configuration.
(set vim.opt.termguicolors true)
(set vim.opt.mouse "a")
(set vim.opt.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set vim.opt.jumpoptions "stack")
(set vim.opt.pumheight 10)

(set vim.opt.textwidth 100)

(set vim.opt.smarttab true)
(set vim.opt.expandtab true)
(set vim.opt.autoindent true)
(set vim.opt.tabstop 2)
(set vim.opt.shiftwidth 2)
(set vim.opt.smartindent true)

(set vim.opt.softtabstop 2)
(set vim.opt.ignorecase true)
(set vim.opt.smartcase true)
(set vim.opt.infercase true)
(set vim.opt.numberwidth 2)
(set vim.opt.signcolumn "yes")
(set vim.opt.undofile true)
(set vim.opt.scrolloff 4)
(set vim.opt.cursorline true)
(set vim.opt.incsearch false)
(vim.cmd "set diffopt+=linematch:800,algorithm:patience")

(when (= (vim.fn.executable "rg") 1)
  (do
    (set vim.opt.grepformat "%f:%l:%c:%m,%f:%l:%m")
    (set vim.opt.grepprg "rg --vimgrep --no-heading --smart-case")))

(set vim.opt.showmode false)
(set vim.opt.showcmd false)
(set vim.opt.ruler false)

(set vim.opt.hidden true)
(set vim.opt.updatetime 50)
(set vim.opt.clipboard "unnamedplus")
(set vim.opt.laststatus 3)
(set vim.opt.redrawtime 150)
(set vim.opt.relativenumber true)
(set vim.opt.listchars {:nbsp :⦸
                        :extends "»"
                        :precedes "«"
                        :tab :->
                        :trail :•})
(set vim.opt.fillchars "eob: ,fold: ,foldopen:,foldsep: ,foldclose:")
(vim.opt.fillchars:append {:diff "╱"})
(set vim.opt.foldcolumn :1)
(set vim.opt.foldlevel 99)
(set vim.opt.foldlevelstart 99)
(set vim.opt.foldenable true)
(set vim.opt.splitkeep "screen")

(set vim.opt.winwidth 10)
(set vim.opt.winminwidth 10)
(set vim.opt.equalalways false)

(vim.cmd "filetype plugin indent on")

(set vim.opt.list true)
(set vim.opt.wrap false)
(set vim.opt.swapfile false)
(set vim.opt.backup false)
(set vim.opt.number true)
(set vim.opt.splitbelow true)
(set vim.opt.splitright true)

(set vim.opt.lispoptions "expr:1")

(set vim.g.clipboard {:name :win32yank-wsl
                      :copy {:+ "win32yank.exe -i --crlf"
                             :* "win32yank.exe -i --crlf"}
                      :paste {:+ "win32yank.exe -o --lf"
                              :* "win32yank.exe -o --lf"}
                      :cache_enable false})

(augroup :init
         [[:CmdWinEnter] {:buffer 0 :command "cmap q <C-W>q"}]
         [[:TextYankPost] {:callback #(vim.highlight.on_yank {:highlight "Visual"
                                                              :timeout 150
                                                              :on_visual true})}]
         [[:FocusGained :TermClose :TermLeave] {:command "checktime"}]
         [[:BufEnter] {:callback #(set vim.opt.formatoptions (- vim.opt.formatoptions "o"))}]
         [[:WinClosed] {:nested true
                        :command "if expand('<amatch>') == win_getid() | wincmd p | endif"}])
