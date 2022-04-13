(module dotfiles.plugin.treesitter)

(defn get-ft-query [ft type]
  (let [path (.. (vim.fn.stdpath :config) (.. "/queries/" ft "/" type ".scm"))]
    (vim.fn.join (vim.fn.readfile path) "\n")))

(let [tsconfigs (require :nvim-treesitter.configs)
      parsers (require :nvim-treesitter.parsers)
      parsers-conf (parsers.get_parser_configs)
      vim-ts-queries (require :vim.treesitter.query)]

  ;; (tset parsers-conf :fennel {:install_info {:url "~/workspace/tree-sitter-fennel"
  ;;                                            :files [:src/parser.c]
  ;;                                            :requires_generate_from_grammar true}
  ;;                             :filetype :fennel})

  (tsconfigs.setup
    {:ensure_installed [:c :cpp :rust :lua :python :cmake :vim :fennel :query :ocaml :ocaml_interface :haskell :scheme]
     :highlight {:enable true
                 :disable [:vim]
                 :additional_vim_regex_highlighting false}
     :indent {:enable false}}))

  ;; (when (parsers.has_parser :fennel)
  ;;   (vim-ts-queries.set_query
  ;;     :fennel
  ;;     :highlights
  ;;     (get-ft-query :fennel :highlights))
  ;;
  ;;   (vim-ts-queries.set_query
  ;;     :fennel
  ;;     :locals
  ;;     (get-ft-query :fennel :locals))))
