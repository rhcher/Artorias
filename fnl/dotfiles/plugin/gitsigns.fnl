(module dotfiles.plugin.gitsigns
  {autoload {gitsigns gitsigns}})

(def- on_attach
  (fn [bufnr]
    (let [gs package.loaded.gitsigns
          map (fn [mode l r opts]
                (var opts (or opts {}))
                (tset opts :buffer bufnr)
                (vim.keymap.set mode l r opts))]
      (map :n "]c" "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" {:expr true})
      (map :n "[c" "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" {:expr true})
      (map [:n :v] :<leader>hs gs.stage_hunk)
      (map [:n :v] :<leader>hr gs.reset_hunk)
      (map :n :<leader>hS gs.stage_buffer)
      (map :n :<leader>hu gs.undo_stage_hunk)
      (map :n :<leader>hR gs.reset_buffer)
      (map :n :<leader>hp gs.preview_hunk)
      (map :n :<leader>hb (fn [] (gs.blame_line {:full true})))
      (map :n :<leader>tb gs.toggle_current_line_blame)
      (map :n :<leader>hd gs.diffthis)
      (map :n :<leader>hD (fn [] (gs.diffthis "~")))
      (map :n :<leader>td gs.toggle_deleted))))


(gitsigns.setup
  {:sign_priority 5
   :on_attach on_attach
   :signs {:add {:hl :DiffAdd
                 :text "│"
                 :numhl "GitSignsAddNr"}
           :change {:hl :DiffChange
                    :text "│"
                    :numhl "GitSignsChangeNr"}
           :changedelete {:hl :DiffChange
                          :text "~"
                          :numhl "GitSignsChangeNr"}
           :delete {:hl "DiffDelete"
                    :text "_"
                    :numhl "GitsignsDeleteNr"}
           :topdelete {:hl "DiffDelete"
                       :text "‾"
                       :numhl "GitSignsDeleteNr"}}
   :status_formatter nil
   :watch_gitdir {:interval 100}})
