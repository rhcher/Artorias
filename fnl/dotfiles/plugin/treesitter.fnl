(module dotfiles.plugin.treesitter)

(when-let [(_ tsconfigs) (pcall require :nvim-treesitter.configs)]
  (tsconfigs.setup
    {:ensure_installed [:c :cpp :rust :lua :python :cmake 
                        :vim :fennel :query :ocaml :ocaml_interface :haskell :scheme]
     :highlight {:enable true
                 :disable [:c :cpp :help]
                 :additional_vim_regex_highlighting false}
     :indent {:enable false}
     :textobjects {:select {:enable true
                            :lookahead true
                            :keymaps {:af "@function.outer"
                                      :if "@function.inner"}}}}))
