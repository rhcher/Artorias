(module dotfiles.plugin.splitjoin)

(vim.keymap.set :n
                :<leader>j
                :<cmd>SplitjoinSplit<CR>
                {:silent true :noremap true})

(vim.keymap.set :n
                :<leader>k
                :<cmd>SplitjoinJoin<CR>
                {:silent true :noremap true})
