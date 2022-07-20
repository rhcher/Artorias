(module dotfiles.mapping
  {autoload {nvim aniseed.nvim
             nu aniseed.nvim.util
             core aniseed.core}
   require-macros [dotfiles.macros]})

;; Generic mapping configuration.
(map :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;; insert-mode
(map :i :jk :<esc>)
(map :i :<C-j> :<esc>o)
(map :i :<C-k> :<esc>O)

(vim.cmd "imap <expr> <C-l> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Esc>A'")
(vim.cmd "smap <expr> <C-l> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Esc>A'")
(vim.cmd "imap <expr> <C-h> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<Esc>I'")
(vim.cmd "smap <expr> <C-h> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<Esc>I'")

(map :n :<leader>bS ":SudaWrite<CR>")

;; terminal-mode
(map :t :<a-h> :<C-\><C-n><C-w>h)
(map :t :<a-j> :<C-\><C-n><C-w>j)
(map :t :<a-k> :<C-\><C-n><C-w>k)
(map :t :<a-l> :<C-\><C-n><C-w>l)
(map :t :<esc> :<C-\><C-n>)

;; x-mode
(map :x ":" ";")
(map :x ";" ":")

;; normal-mode
(map :n ":" ";")
(map :n ";" ":")
(map :n :<esc> ":nohl<CR>")
(map :n :n :nzz {:silent true})
(map :n :N :Nzz {:silent true})
(map :n :<A-h> :<C-w>h)
(map :n :<A-j> :<C-w>j)
(map :n :<A-k> :<C-w>k)
(map :n :<A-l> :<C-w>l)
(map :n :<leader>bs ":w <CR>")
(map :n :<leader>wm ":tab sp<cr>")
(map :n :<leader>wc ":only<cr>")
; (map :n :<leader>bk ":bdelete!<cr>")
(map :n :<leader>to ":tabonly<cr>")
(map :n :<leader>sw ":mksession! .quicksave.vim<cr>")
(map :n :<leader>sr ":source .quicksave.vim<cr>")
;; Delete hidden buffers.
; (map :n :<leader>bo ":call DeleteHiddenBuffers()<cr>")
;; Correct to first spelling suggestion.
(map :n :<leader>zz ":normal! 1z=<cr>")
;; Trim trialing whitespace.
(map :n :<leader>bt ":%s/\\s\\+$//e<cr>")

(map :n "[b" :<cmd>bprev<CR>)
(map :n "]b" :<cmd>bnext<CR>)

(map [:n :v] :gx "<Plug>(openbrowser-smart-search)")

(map :n :cx "<Plug>(Exchange)")
(map :x :X "<Plug>(Exchange)")
(map :n :cxc "<Plug>(ExchangeClear)")
(map :n :cxx "<Plug>(ExchangeLine)")

(map :n :n "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz")
(map :n :N "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz")
(map :n :* "*<Cmd>lua require('hlslens').start()<CR>")
(map :n :# "#<Cmd>lua require('hlslens').start()<CR>")
(map :n :g* "g*<Cmd>lua require('hlslens').start()<CR>")
(map :n :g# "g#<Cmd>lua require('hlslens').start()<CR>")

(map :n :<leader>e ":NvimTreeToggle<CR>")
(map :n :<leader>r ":NvimTreeRefresh<CR>") 

(map :n :<leader>gg ":Git<CR>")
(map :n :<leader>ou ":UndotreeShow<cr>:UndotreeFocus<cr>")

(map :n :s "<Plug>Lightspeed_omni_s")

(let [fzf (require "fzf-lua")]
  (map :n :<leader>ff fzf.files)
  (map :n :<leader>fp (fn [] (fzf.files {:cwd "~/.config/nvim/"})))
  (map :n :<leader>fs fzf.live_grep_native)
  (map :n :<leader>fb fzf.buffers)
  (map :n :<leader>bb fzf.buffers)
  (map :n :<leader>fh fzf.help_tags)
  (map :n :<leader>fk fzf.keymaps)
  (map :n :<leader>fl fzf.blines)
  (map :n :<leader>pl fzf.lines)
  (map :n :<leader>fo fzf.oldfiles)
  (map :n :<leader>fc fzf.commands)
  (map :n :<leader>fq fzf.quickfix)
  (map :n :<leader>fg fzf.git_bcommits))

(vim.api.nvim_create_autocmd [:FileType]
                             {:pattern [:git :qf :man :help :lspinfo :fugitive :gitcommit]
                              :command "nnoremap <buffer><silent> q :close<CR>"})

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
