(module dotfiles.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}})

(treesitter.setup
  {:ensure_installed [:c :cpp :rust :lua :python :cmake :vim :fennel :query :ocaml :ocaml_interface]
   :highlight {:enable true
               :additional_vim_regex_highlighting false}
   :indent {:enable false}})
