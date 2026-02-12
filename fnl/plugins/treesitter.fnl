(import-macros {: tx} :config.macros)

(vim.api.nvim_create_autocmd "FileType" {:pattern "fennel"
                                         :callback #(vim.treesitter.start)})

(tx "nvim-treesitter/nvim-treesitter"
    {:lazy false
     :branch "main"
     :build ":TSUpdate"
     :config #(let [ts (require "nvim-treesitter")]
                (ts.install [:c :cpp :rust :lua :python :cmake :markdown :markdown_inline
                             :vim :fennel :query :ocaml :ocaml_interface :haskell :scheme
                             :regex :bash :luap :racket :html]))})
