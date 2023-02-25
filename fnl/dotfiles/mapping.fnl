(module dotfiles.mapping
  {autoload {nvim aniseed.nvim
             nu aniseed.nvim.util
             core aniseed.core}
   import-macros [[m :dotfiles.macros]
                  [ac :aniseed.macros.autocmds]]})

;; Generic mapping configuration.
(m.map :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;; insert-mode
(m.map :i :jk :<esc>)
(m.map :i :<C-j> :<esc>o)
(m.map :i :<C-k> :<esc>O)

(m.map :n :<leader><leader> ":Inspect<CR>")

;; terminal-mode
(m.map :t :<a-h> :<C-\><C-n><C-w>h)
(m.map :t :<a-j> :<C-\><C-n><C-w>j)
(m.map :t :<a-k> :<C-\><C-n><C-w>k)
(m.map :t :<a-l> :<C-\><C-n><C-w>l)
(m.map :t :<esc> :<C-\><C-n>)

;; normal-mode
(m.map :n :<esc> ::noh<CR>)
(m.map :n :n :nzz {:silent true})
(m.map :n :N :Nzz {:silent true})
(m.map :n :<A-h> :<C-w>h)
(m.map :n :<A-j> :<C-w>j)
(m.map :n :<A-k> :<C-w>k)
(m.map :n :<A-l> :<C-w>l)
(m.map :n :<leader>bs ":w <CR>")
(m.map :n :<leader>wm ":tab sp<cr>")
(m.map :n :<leader>wc ":only<cr>")
(m.map :n :<leader>to ":tabonly<cr>")
;; Delete hidden buffers.
; (map :n :<leader>bo ":call DeleteHiddenBuffers()<cr>")
;; Correct to first spelling suggestion.
(m.map :n :<leader>zz ":normal! 1z=<cr>")
;; Trim trialing whitespace.
(m.map :n :<leader>bt ":%s/\\s\\+$//e<cr>")

(m.map :n "[b" :<cmd>bprev<CR>)
(m.map :n "]b" :<cmd>bnext<CR>)

(m.map [:n :v] :gx "<Plug>(openbrowser-smart-search)")

(m.map :n :cx "<Plug>(Exchange)")
(m.map :x :X "<Plug>(Exchange)")
(m.map :n :cxc "<Plug>(ExchangeClear)")
(m.map :n :cxx "<Plug>(ExchangeLine)")

(m.map :n :<leader>e ":Oil<CR>")

(m.map :n :<leader>gg ":Git<CR><C-w>o")
(m.map :n :<leader>ou ":UndotreeShow<cr>:UndotreeFocus<cr>")

(ac.autocmd [:FileType]
            {:pattern [:git :qf :man :help :lspinfo :fugitive :gitcommit]
             :command "nnoremap <buffer><silent> q :close<CR>"})

;; fugitive remapping
(set vim.g.nremap {"[m" "[f" "]m" "]f" "=" :o})

(nu.fn-bridge
  :DeleteHiddenBuffers
  :dotfiles.mapping :delete-hidden-buffers)

(defn delete-hidden-buffers []
  (let [visible-bufs (->> (nvim.fn.range 1 (nvim.fn.tabpagenr :$))
                          (core.map nvim.fn.tabpagebuflist)
                          (unpack)
                          (core.concat))]
    (->> (nvim.fn.range 1 (nvim.fn.bufnr :$))
         (core.filter
           (fn [bufnr]
             (and (nvim.fn.bufexists bufnr)
                  (= -1 (nvim.fn.index visible-bufs bufnr)))))
         (core.run!
           (fn [bufnr]
             (nvim.ex.bwipeout bufnr))))))
