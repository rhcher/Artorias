(import-macros {: map : autocmd} :dotfiles.macros)

;; Generic mapping configuration.
(map :n :<space> :<nop> {:noremap true})
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

;; insert-mode
(map :i :jk :<esc>)
(map :i :<C-j> :<esc>o)
(map :i :<C-k> :<esc>O)

(map :n :<leader><leader> ":Inspect<CR>")

;; terminal-mode
(map :t :<a-h> :<C-\><C-n><C-w>h)
(map :t :<a-j> :<C-\><C-n><C-w>j)
(map :t :<a-k> :<C-\><C-n><C-w>k)
(map :t :<a-l> :<C-\><C-n><C-w>l)
(map :t :<esc> :<C-\><C-n>)

;; normal-mode
(map :n :<esc> ::noh<CR>)
(map :n :n :nzz {:silent true})
(map :n :N :Nzz {:silent true})
(map :n :<A-h> :<C-w>h)
(map :n :<A-j> :<C-w>j)
(map :n :<A-k> :<C-w>k)
(map :n :<A-l> :<C-w>l)
(map :n :<leader>bs ":w <CR>")
(map :n :<leader>wm ":tab sp<cr>")
(map :n :<leader>wc ":only<cr>")
(map :n :<leader>to ":tabonly<cr>")
;; Correct to first spelling suggestion.
(map :n :<leader>zz ":normal! 1z=<cr>")
;; Trim trialing whitespace.
(map :n :<leader>bt ":%s/\\s\\+$//e<cr>")

(map :n "[b" :<cmd>bprev<CR>)
(map :n "]b" :<cmd>bnext<CR>)

(map [:n :v] :gx "<Plug>(openbrowser-smart-search)")

(map :n :<leader>e ":Oil<CR>")

(map :n :<leader>gg ":Git<CR><C-w>o")
(map :n :<leader>ou ":UndotreeShow<cr>:UndotreeFocus<cr>")

(autocmd [:FileType]
         {:pattern [:git :qf :man :help :lspinfo :fugitive :gitcommit]
          :command "nnoremap <buffer><silent> q :close<CR>"})

;; fugitive remapping
(set vim.g.nremap {"[m" "[f" "]m" "]f" "=" :o})
