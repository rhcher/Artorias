(import-macros {: tx : map} :config.macros)

(local {: autoload} (require :nfnl.module))
(local gitsigns (autoload :gitsigns))

(local on_attach
  (fn [bufnr]
    (let [gs package.loaded.gitsigns]
      (map :n "]c" #(if vim.wo.diff
                        "]c"
                        (do
                          (vim.schedule #(gs.next_hunk))
                          "<Ignore>"))
           {:expr true})
      (map :n "[c" #(if vim.wo.diff
                        "[c"
                        (do
                          (vim.schedule #(gs.prev_hunk))
                          "<Ignore>"))
           {:expr true})
      (map [:n :v] :<leader>hs gs.stage_hunk)
      (map [:n :v] :<leader>hr gs.reset_hunk)
      (map :n :<leader>hS gs.stage_buffer)
      (map :n :<leader>hu gs.undo_stage_hunk)
      (map :n :<leader>hR gs.reset_buffer)
      (map :n :<leader>hp gs.preview_hunk)
      (map :n :<leader>hb #(gs.blame_line {:full true}))
      (map :n :<leader>tb gs.toggle_current_line_blame)
      (map :n :<leader>hd gs.diffthis)
      (map :n :<leader>hD #(gs.diffthis "~"))
      (map :n :<leader>td gs.toggle_deleted)
      (map [:x :o] :ih ":<C-U>Gitsigns select_hunk<CR>"))))

(map :n :<leader>gg ":Git<CR><C-w>o")
(set vim.g.nremap {"[m" "[f" "]m" "]f" "=" "<tab>"})

[(tx "tpope/vim-fugitive" {:cmd "Git"})
 (tx "lewis6991/gitsigns.nvim"
     {:event ["BufReadPre" "BufNewFile"]
      :opts {:sign_priority 5
             :on_attach on_attach
             :signs {:add {:text "│"}
                     :change {:text "│"}
                     :changedelete {:text "~"}
                     :delete {:text "_"}
                     :topdelete {:text "‾"}}
             :status_formatter nil
             :watch_gitdir {:interval 100}}})
 (tx "esmuellert/vscode-diff.nvim"
     {:dependencies ["MunifTanjim/nui.nvim"]
      :cmd "CodeDiff"
      :branch "next"
      :config #(let [codediff (require :codediff)]
                 codediff.setup {:highlights {:line_insert "DiffAdd"
                                              :line_delete "DiffDelete"
                                              :char_insert "DiffText"
                                              :char_delete "DiffDelete"
                                              :char_brightness "DiffText"}})})
 (tx "chrisgrieser/nvim-spider" {:keys [{1 "w" 2 "<cmd>lua require('spider').motion('w')<CR>" :mode [:n :o :x]}
                                        {1 "e" 2 "<cmd>lua require('spider').motion('e')<CR>" :mode [:n :o :x]}
                                        {1 "b" 2 "<cmd>lua require('spider').motion('b')<CR>" :mode [:n :o :x]}
                                        {1 "ge" 2 "<cmd>lua require('spider').motion('ge')<CR>" :mode [:n :o :x]}]})]
