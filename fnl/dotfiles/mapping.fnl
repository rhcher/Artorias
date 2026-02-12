(import-macros {: map : augroup} :dotfiles.macros)

;; Generic mapping configuration.
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

;; insert-mode
(map :i :<C-j> :<C-o>o)
(map :i :<C-k> :<C-o>O)

(map :n :<leader><leader> ":Inspect<CR>")

;; terminal-mode
(map :t :<a-h> :<C-\><C-n><C-w>h)
(map :t :<a-j> :<C-\><C-n><C-w>j)
(map :t :<a-k> :<C-\><C-n><C-w>k)
(map :t :<a-l> :<C-\><C-n><C-w>l)
; (map :t :<esc> :<C-\><C-n>)

;; normal-mode
(map :n :<esc> ::noh<CR>)
(map :n :n :nzz {:silent true})
(map :n :N :Nzz {:silent true})
(map :n :<A-h> :<C-w>h)
(map :n :<A-j> :<C-w>j)
(map :n :<A-k> :<C-w>k)
(map :n :<A-l> :<C-w>l)
(map :n :<leader>bs ":w<CR>")
(map :n :<leader>wm ":tabnew %<cr>")
(map :n :<leader>wc ":only<cr>")
(map :n :<leader>to ":tabonly<cr>")
(map :n :<leader>td ":tabclose<cr>")
;; Correct to first spelling suggestion.
(map :n :<leader>zz ":normal! 1z=<cr>")
;; Trim trialing whitespace.
(map :n :<leader>bt ":%s/\\s\\+$//e<cr>")

(map :n "[b" :<cmd>bprev<CR>)
(map :n "]b" :<cmd>bnext<CR>)
(map :n "[t" :<cmd>tabp<CR>)
(map :n "]t" :<cmd>tabn<CR>)

; (map :n :<leader>e ":Oil<CR>")

(map :n :<leader>gg ":Git<CR><C-w>o")
(map :n :<leader>ou ":UndotreeShow<cr>:UndotreeFocus<cr>")

(vim.keymap.del "n" "grr")
(vim.keymap.del "n" "grn")
(vim.keymap.del "n" "gra")
(vim.keymap.del "n" "gri")
(vim.keymap.del "n" "grt")

(augroup :InputQquitEverythingIwant
         [[:FileType] {:pattern [:git :qf :man :help :lspinfo :fugitive :gitcommit]
                       :callback #(map [:n :v] :q ":close<CR>" {:buffer true})}]
         [[:FileType] {:pattern ["*"]
                       :callback #(when (= vim.bo.buftype "nofile")
                                    (map [:n :v] :q ":close<CR>" {:buffer true}))}]
         [[:BufEnter] {:pattern ["*"]
                       :callback #(when (and (= vim.bo.filetype "") (= vim.bo.buftype ""))
                                    (map [:n :v] :q ":close<CR>" {:buffer true}))}])

;; fugitive remapping
(set vim.g.nremap {"[m" "[f" "]m" "]f" "=" "<tab>"})
