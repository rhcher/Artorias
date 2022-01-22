(module dotfiles.plugin.auto-pairs
  {autoload {core aniseed.core
             nvim aniseed.nvim}})

(vim.cmd "let delimitMate_autoclose = 1")
(vim.cmd "let delimitMate_expand_cr = 1")
(vim.cmd "let delimitMate_excluded_regions = \"String\"")
(nvim.ex.autocmd :FileType
                 "clojure,fennel,scheme,racket,ocaml"
                 "let b:delimitMate_quotes = '\" `'")
