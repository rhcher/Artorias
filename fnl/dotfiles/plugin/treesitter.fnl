(module dotfiles.plugin.treesitter)

(let [tsconfigs (require :nvim-treesitter.configs)]
  (tsconfigs.setup
    {:ensure_installed [:c :cpp :rust :lua :python :cmake 
                        :vim :fennel :query :ocaml :ocaml_interface :haskell :scheme]
     :highlight {:enable true
                 :disable [:c :cpp]
                 :additional_vim_regex_highlighting false}
     :indent {:enable false}}))
