(module dotfiles.plugin.nvimtree
  {autoload {nvim aniseed.nvim}})

(let [tree (require "nvim-tree")]
  (tree.setup))
