(module dotfiles.ftplugin.c
  {autoload {lsp dotfiles.plugin.lspconfig}})

(lsp.safe-start
  #(vim.lsp.start
     {:name "ccls"
      :cmd ["ccls"]
      :capabilities (lsp.capabilities)
      :init_options lsp.ccls_config
      :root_dir (lsp.root-pattern [".ccls" "compile-commands.json" ".ccls-root" ".git"])
      :flags lsp.flags}))

(defn clangd-capabilities []
  (var capabilities (lsp.capabilities))
  (tset capabilities.textDocument.completion :editsNearCursor true)
  (tset capabilities :offsetEncoding ["utf-8" "utf-16"])
  capabilities)

;; (defn start []
;;   (local bufnr (vim.api.nvim_get_current_buf))
;;   (when (not= (vim.api.nvim_buf_get_option bufnr "buftype") "nofile")
;;     (vim.lsp.start
;;       {:name "clangd"
;;        :cmd ["clangd" "--header-insertion=never" "--background-index" "--cross-file-rename"]
;;        :capabilities (clangd-capabilities)
;;        :root_dir (lsp.root-pattern [".clangd" ".clang-tidy" ".clang-format" "compile-commands.json" "compile_flags.txt" "configure.ac"])
;;        :single_support true
;;        :flags lsp.flags})))

;; (start)
