(module dotfiles.plugin.nvimtree)

(let [tree (require "nvim-tree")]
  (tree.setup {:disable_netrw false
               :hijack_netrw false
               :hijack_cursor true
               :update_cwd true
               :git {:enable false
                     :ignore false}}))

(vim.keymap.set :n :<leader>e ":NvimTreeToggle<CR>" {:noremap true :silent true})
(vim.keymap.set :n :<leader>r ":NvimTreeRefresh<CR>" {:noremap true :silent true})
