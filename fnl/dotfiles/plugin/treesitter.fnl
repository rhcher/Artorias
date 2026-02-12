(import-macros {: autocmd} "dotfiles.macros")

(let [(_ ts) (pcall require :nvim-treesitter)]
  (ts.setup
    {:install_dir (.. (vim.fn.stdpath "data") "/site")})
  (ts.install [:cpp :rust :python :cmake :markdown :markdown_inline
               :vim :fennel :query :ocaml :ocaml_interface :haskell :scheme
               :regex :bash :luap :racket :html :zig]))

(autocmd "FileType" {:pattern [:fennel :zig]
                     :callback #(vim.treesitter.start)})
