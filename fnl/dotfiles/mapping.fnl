(module dotfiles.mapping
  {autoload {nvim aniseed.nvim
             nu aniseed.nvim.util
             core aniseed.core
             ccls dotfiles.ccls}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true :silent true}))

(defn- luamap [mode from callback]
  (nvim.set_keymap mode from "" {:noremap true :callback callback}))

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
(noremap :n :<leader>bk ":bdelete!<cr>")
(noremap :n :<leader>to ":tabonly<cr>")
(noremap :n :<leader>sw ":mksession! .quicksave.vim<cr>")
(noremap :n :<leader>sr ":source .quicksave.vim<cr>")
;; Delete hidden buffers.
(noremap :n :<leader>bo ":call DeleteHiddenBuffers()<cr>")
;; Correct to first spelling suggestion.
(noremap :n :<leader>zz ":normal! 1z=<cr>")
;; Trim trialing whitespace.
(noremap :n :<leader>bt ":%s/\\s\\+$//e<cr>")
;; nvim-tree
(noremap :n :<leader>e ":NvimTreeToggle<CR>")
;; ccls navigate
(luamap :n :<C-k> (fn [] (ccls.navigate :L)))
(luamap :n :<C-j> (fn [] (ccls.navigate :R)))
(luamap :n :<C-l> (fn [] (ccls.navigate :D)))
(luamap :n :<C-h> (fn [] (ccls.navigate :U)))
;; ccla call
(luamap :n :<space>ii (fn [] (ccls.call :caller)))
(luamap :n :<space>io (fn [] (ccls.call :callee)))
;; ccls var
(luamap :n :<space>vf (fn [] (ccls.ccls_var :field)))
(luamap :n :<space>vl (fn [] (ccls.ccls_var :local)))
(luamap :n :<space>vp (fn [] (ccls.ccls_var :parameter)))
;; ccls member
(luamap :n :<space>mv (fn [] (ccls.member :variables)))
(luamap :n :<space>mf (fn [] (ccls.member :functions)))
(luamap :n :<space>mt (fn [] (ccls.member :types)))
;; ccls inheritance
(luamap :n :<space>ib (fn [] (ccls.inheritance :base)))
(luamap :n :<space>id (fn [] (ccls.inheritance :derived)))
;; ccls references extend
(luamap :n :<space>gw (fn [] (ccls.extend_ref :write)))
(luamap :n :<space>gr (fn [] (ccls.extend_ref :read)))
(luamap :n :<space>gm (fn [] (ccls.extend_ref :macro)))
(luamap :n :<space>gn (fn [] (ccls.extend_ref :notcall)))

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
