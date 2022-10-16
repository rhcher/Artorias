(module dotfiles.ftplugin.python
  {autoload {lsp dotfiles.plugin.lspconfig}})

(set vim.opt_local.autoindent true)
(set vim.opt_local.cindent true)
(set vim.opt_local.copyindent true)
(set vim.opt_local.expandtab true)
(set vim.opt_local.smartindent true)
(set vim.opt_local.shiftwidth 4)
(set vim.opt_local.smarttab true)
(set vim.opt_local.softtabstop 4)
(set vim.opt_local.tabstop 8)

(vim.lsp.start
  {:name "pylsp"
   :cmd ["pylsp"]
   :capabilities (lsp.capabilities)
   :settings lsp.pylsp_config
   :root_dir (lsp.root-pattern [".git"])
   :single_file_support true
   :flags lsp.flags})
