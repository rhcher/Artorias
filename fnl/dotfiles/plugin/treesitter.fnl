(module dotfiles.plugin.treesitter)

(when-let [(_ tsconfigs) (pcall require :nvim-treesitter.configs)]
  (tsconfigs.setup
    {:ensure_installed [:c :cpp :rust :lua :python :cmake :markdown :markdown_inline
                        :vim :fennel :query :ocaml :ocaml_interface :haskell :scheme
                        :regex :bash :luap :racket]
     :highlight {:enable true
                 :disable [:c :cpp :help :lua]
                 :additional_vim_regex_highlighting false}
     :indent {:enable false}}))
