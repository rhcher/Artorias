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
  {:name "pyright"
   :cmd ["pyright-langserver" "--stdio"]
   :capabilities (lsp.capabilities)
   :settings lsp.pyright_config
   :root_dir (lsp.root-pattern ["pyproject.toml" "setup.py" "setup.cfg"
                                "requirements.txt" "Pipfile" "pyrightconfig.json"])
   :single_file_support true
   :flags lsp.flags
   :commands {:PyrightOrganizeImports {1 (fn []
                                           (let [params {:command "pyright.organizeimports"
                                                         :arguments [(vim.uri_from_bufnr 0)]}]
                                             (vim.lsp.buf.execute_command params)))
                                       :description "Organize Imports"}}})
