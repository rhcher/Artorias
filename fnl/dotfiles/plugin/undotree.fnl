(module dotfiles.plugin.undotree)

(vim.keymap.set :n
                 :<leader>ut
                 ":UndotreeShow<cr>:UndotreeFocus<cr>"
                 {:noremap true :silent true})
