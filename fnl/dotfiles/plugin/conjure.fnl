(import-macros {: autocmd : augroup} :dotfiles.macros)

(set vim.g.conjure#filetype#rust false)

(augroup "conjure-log-no-diag"
         [[:BufNewFile]
          {:pattern ["conjure-log-*"]
           :command "lua vim.diagnostic.disable(0)"}])
