(module dotfiles.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}})

(treesitter.setup
  {:ensure_installed [:c :cpp :rust :lua :python :cmake :vim :fennel :query]
   :highlight {:enable true
               :additional_vim_regex_highlighting false}
   :indent {:enable false}
   :matchup {:enable true
             :disable_virtual_text false
             :include_match_word false}})
