(module dotfiles.plugin.nvimtree
  {autoload {nvim aniseed.nvim}})

(let [tree (require "nvim-tree")]
  (tree.setup {:hijack_cursor true
               :update_cwd true
               :update_focused_file {:enable true
                                     :update_cwd true}
               :git {:ignore false}}))
