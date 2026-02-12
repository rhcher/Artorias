(import-macros {: augroup} "dotfiles.macros")

(set vim.opt.mouse "a")
(set vim.opt.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set vim.opt.jumpoptions "stack")
(set vim.opt.pumheight 10)
(set vim.opt.exrc true)
(set vim.opt.termsync true)
(set vim.opt.smoothscroll true)

; (vim.cmd.colorscheme :srcery)

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
(set vim.opt.cursorline true)
(set vim.opt.incsearch false)
; (vim.cmd "set diffopt+=inline:word,algorithm:histogram")

(when (= (vim.fn.executable "rg") 1)
  (do
    (set vim.opt.grepformat "%f:%l:%c:%m,%f:%l:%m")
    (set vim.opt.grepprg "rg --vimgrep --no-heading --smart-case")))

(set vim.opt.showmode false)
(set vim.opt.showcmd false)
(set vim.opt.ruler false)

(set vim.opt.hidden true)
(set vim.opt.updatetime 100)
(set vim.opt.laststatus 3)
(set vim.opt.redrawtime 150)
(set vim.opt.lazyredraw true)
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

(augroup :init
         [[:TextYankPost] {:callback #(vim.hl.on_yank {:higroup "Visual"})}]
         [[:BufEnter] {:callback #(set vim.opt.formatoptions (- vim.opt.formatoptions "o"))}]
         [[:UIEnter] {:callback #(set vim.o.clipboard "unnamedplus")}]
         [[:FileType] {:pattern "cpp" :command "set cinkeys-=:"}]
         [[:FileType] {:pattern ["fennel" "markdown" "harpoon"] :callback #(set vim.b.snacks_indent false)}])

(when vim.g.neovide
  (set vim.g.neovide_confirm_quit false)
  (set vim.g.neovide_fullscreen true)
  (set vim.g.neovide_hide_mouse_when_typing true))
