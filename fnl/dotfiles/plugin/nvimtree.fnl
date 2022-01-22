(module dotfiles.plugin.nvimtree
  {autoload {nvim aniseed.nvim}})

(let [tree (require "nvim-tree")]
  (tree.setup {:disable_netrw false
               :hijack_netrw false
               :hijack_cursor true
               :update_cwd true
               :git {:enable false
                     :ignore false}}))
