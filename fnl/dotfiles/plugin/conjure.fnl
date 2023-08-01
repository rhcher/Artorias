(module dotfiles.plugin.conjure
  {import-macros [[{: autocmd : augroup} :aniseed.macros.autocmds]]})

(set vim.g.conjure#filetype#rust false)

(augroup "conjure-log-no-diag"
         [[:BufNewFile]
          {:pattern ["conjure-log-*"]
           :command "lua vim.diagnostic.disable(0)"}])
