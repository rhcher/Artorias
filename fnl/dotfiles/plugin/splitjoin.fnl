(module dotfiles.plugin.splitjoin)

(vim.api.nvim_set_keymap :n
                         :<leader>j
                         :<cmd>SplitjoinSplit<CR>
                         {:silent true :noremap true})

(vim.api.nvim_set_keymap :n
                         :<leader>k
                         :<cmd>SplitjoinJoin<CR>
                         {:silent true :noremap true})
