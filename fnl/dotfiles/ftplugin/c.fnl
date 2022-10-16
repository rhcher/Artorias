(module dotfiles.ftplugin.c
  {autoload {lsp dotfiles.plugin.lspconfig}})

(vim.lsp.start
  {:name "ccls"
   :cmd ["ccls"]
   :capabilities (lsp.capabilities)
   :init_options lsp.ccls_config
   :root_dir (lsp.root-pattern [".ccls" "compile-commands.json" ".ccls-root" ".git"])
   :flags lsp.flags}) 
