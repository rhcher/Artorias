(module dotfiles.plugin.nvimtree
  {autoload {nvim aniseed.nvim}})

(set nvim.g.nvim_tree_highlight_opened_files 1)

(let [tree (require "nvim-tree")]
  (tree.setup {:hijack_cursor true
               :update_cwd true
               :update_focused_file {:enable true
                                     :update_cwd true}
               :git {:ignore false}}))
