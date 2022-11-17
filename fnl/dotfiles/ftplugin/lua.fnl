(module dotfiles.ftplugin.lua
  {autoload {lsp dotfiles.plugin.lspconfig}})

(set vim.b.conjure#mapping#doc_word "gk")

(lsp.safe-start
  #(vim.lsp.start
     {:name "sumneko_lua"
      :cmd ["/home/rhcher/sources/lua-language-server/bin/lua-language-server"]
      :capabilities (lsp.capabilities)
      :settings lsp.sumneko_lua_config
      :root_dir (lsp.root-pattern [".luarc.json" ".luacheckrc" ".stylua.toml" "stylua.toml" "selene.toml" ".git"])
      :single_file_support true
      :flags lsp.flags}))
