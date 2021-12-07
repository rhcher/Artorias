(module dotfiles.plugin.gitsigns
  {autoload {gitsigns gitsigns}})

(gitsigns.setup
  {:keymaps {:buffer true
             :noremap true
             "n <leader>hs" "<cmd>Gitsigns stage_hunk<CR>"
             "v <leader>hs" ":Gitsigns stage_hunk<CR>"
             "n <leader>hS" "<cmd>Gitsigns stage_buffer<CR>"
             "n <leader>hu" "<cmd>Gitsigns undo_stage_hunk<CR>"
             "n <leader>hU" "<cmd>Gitsigns reset_buffer_index<CR>"
             "n <leader>hr" "<cmd>Gitsigns reset_hunk<CR>"
             "v <leader>hr" ":Gitsigns reset_hunk<CR>"
             "n <leader>hR" "<cmd>Gitsigns reset_buffer<CR>"
             "n <leader>hp" "<cmd>Gitsigns preview_hunk<CR>"
             "n <leader>hb" "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>"
             "n <leader>hq" "<cmd>Gitsigns seqloclist<CR>"
             "o ih" ":<C-U>lua require'gitsigns.actions'.select_hunk()<CR>"
             "x ih" ":<C-U>lua require'gitsigns.actions'.select_hunk()<CR>"}
   :sign_priority 5
   :signs {:add {:hl :DiffAdd
                 :text "|"
                 :numhl "GitSignsAddNr"}
           :change {:hl :DiffChange
                    :text "|"
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

(vim.api.nvim_set_keymap :n
                         "]g"
                         "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"
                         {:noremap true :silent true :expr true})

(vim.api.nvim_set_keymap :n
                         "[g"
                         "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"
                         {:noremap true :silent true :expr true})
