(module dotfiles.mapping
  {autoload {nvim aniseed.nvim
             nu aniseed.nvim.util
             core aniseed.core
             ccls dotfiles.ccls}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (vim.keymap.set mode from to {:noremap true :silent true}))

;; Generic mapping configuration.
(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;; insert-mode
(noremap :i :jk :<esc>)
(noremap :i :<C-j> :<esc>o)
(noremap :i :<C-k> :<esc>O)
(vim.cmd "imap <expr> <C-l>   snippy#can_jump(1)  ? '<Plug>(snippy-next)' : '<Esc>A'")
(vim.cmd "smap <expr> <C-l>   snippy#can_jump(1)  ? '<Plug>(snippy-next)' : '<Esc>A'")
(vim.cmd "imap <expr> <C-h>   snippy#can_jump(-1)  ? '<Plug>(snippy-previous)' : '<Esc>I'")
(vim.cmd "smap <expr> <C-h>   snippy#can_jump(-1)  ? '<Plug>(snippy-previous)' : '<Esc>I'")

;; terminal-mode
(noremap :t :<a-h> :<C-\><C-n><C-w>h)
(noremap :t :<a-j> :<C-\><C-n><C-w>j)
(noremap :t :<a-k> :<C-\><C-n><C-w>k)
(noremap :t :<a-l> :<C-\><C-n><C-w>l)
(noremap :t :<esc> :<C-\><C-n>)

;; x-mode
(noremap :x ":" ";")
(noremap :x ";" ":")

;; normal-mode
(noremap :n ":" ";")
(noremap :n ";" ":")
(noremap :n :<esc> ":nohl<CR>")
(vim.api.nvim_set_keymap :n :n :nzz {:silent true})
(vim.api.nvim_set_keymap :n :N :Nzz {:silent true})
(noremap :n :<A-h> :<C-w>h)
(noremap :n :<A-j> :<C-w>j)
(noremap :n :<A-k> :<C-w>k)
(noremap :n :<A-l> :<C-w>l)
(noremap :n :<leader>bs ":w <CR>")
(noremap :n :<leader>wm ":tab sp<cr>")
(noremap :n :<leader>wc ":only<cr>")
; (noremap :n :<leader>bk ":bdelete!<cr>")
(noremap :n :<leader>to ":tabonly<cr>")
(noremap :n :<leader>sw ":mksession! .quicksave.vim<cr>")
(noremap :n :<leader>sr ":source .quicksave.vim<cr>")
;; Delete hidden buffers.
; (noremap :n :<leader>bo ":call DeleteHiddenBuffers()<cr>")
;; Correct to first spelling suggestion.
(noremap :n :<leader>zz ":normal! 1z=<cr>")
;; Trim trialing whitespace.
(noremap :n :<leader>bt ":%s/\\s\\+$//e<cr>")
;; nvim-tree
(noremap :n :<leader>e ":NvimTreeToggle<CR>")

(noremap :n "[b" :<cmd>bprev<CR>)
(noremap :n "]b" :<cmd>bnext<CR>)

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
