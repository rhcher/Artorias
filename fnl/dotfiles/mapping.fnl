(module dotfiles.mapping
  {autoload {nvim aniseed.nvim
             nu aniseed.nvim.util
             core aniseed.core}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true :silent true}))

;; Generic mapping configuration.
(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;; insert-mode
(noremap :i :jj :<esc>)
(noremap :i :<C-j> :<esc>o)
(noremap :i :<C-k> :<esc>O)
(vim.cmd "imap <expr> <C-l>   snippy#can_jump(1)  ? '<Plug>(snippy-next)' : '<Esc>A'")
(vim.cmd "smap <expr> <C-l>   snippy#can_jump(1)  ? '<Plug>snippy-next()' : '<Esc>A'")
(vim.cmd "smap <expr> <C-h>   snippy#can_jump(-1)  ? '<Plug>(snippy-previous)' : '<Esc>I'")
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
(noremap :n :n :nzz)
(noremap :n :N :Nzz)
(vim.cmd "nmap j jzz")
(vim.cmd "nmap k kzz")
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
;; move.nvim
(noremap :v :<A-j> ":MoveBlock(1)<CR>")
(noremap :v :<A-k> ":MoveBlock(-1)<CR>")
(noremap :v :<A-h> ":MoveHBlock(1)<CR>")
(noremap :v :<A-l> ":MoveHBlock(-1)<CR>")
;; ccls navigate
(noremap :n :<C-k> ":lua require(\"dotfiles.ccls\").navigate(\"L\")<CR>")
(noremap :n :<C-j> ":lua require(\"dotfiles.ccls\").navigate(\"R\")<CR>")
(noremap :n :<C-l> ":lua require(\"dotfiles.ccls\").navigate(\"D\")<CR>")
(noremap :n :<C-h> ":lua require(\"dotfiles.ccls\").navigate(\"U\")<CR>")
;; ccla call
(noremap :n :<space>ii ":lua require(\"dotfiles.ccls\").call(true)<CR>")
(noremap :n :<space>io ":lua require(\"dotfiles.ccls\").call(false)<CR>")
;; ccls var
(noremap :n :<space>vf ":lua require(\"dotfiles.ccls\").ccls_var(\"field\")<CR>")
(noremap :n :<space>vl ":lua require(\"dotfiles.ccls\").ccls_var(\"local\")<CR>")
(noremap :n :<space>vp ":lua require(\"dotfiles.ccls\").ccls_var(\"parameter\")<CR>")
;; ccls member
(noremap :n :<space>mv ":lua require(\"dotfiles.ccls\").member(\"variables\")<CR>")
(noremap :n :<space>mf ":lua require(\"dotfiles.ccls\").member(\"functions\")<CR>")
(noremap :n :<space>mt ":lua require(\"dotfiles.ccls\").member(\"types\")<CR>")

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
