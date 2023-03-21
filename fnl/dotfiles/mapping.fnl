(module dotfiles.mapping
  {autoload {nvim aniseed.nvim
             nu aniseed.nvim.util
             core aniseed.core}
   import-macros [[{: map} :dotfiles.macros]
                  [{: autocmd} :aniseed.macros.autocmds]]})

;; Generic mapping configuration.
(map :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

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
;; Delete hidden buffers.
; (map :n :<leader>bo ":call DeleteHiddenBuffers()<cr>")
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
