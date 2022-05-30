(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             cmplsp cmp_nvim_lsp
             lsp_util vim.lsp.util
             utils lspconfig.util}})

(defn- on_attach [client bufnr]

  (defn- buf_key_map [mode from to]
    (vim.keymap.set mode from to {:buffer true :noremap true :silent true}))

  (defn- buf_set_option [...]
    (vim.api.nvim_buf_set_option bufnr ...))

  (when client.server_capabilities.completionProvider
    (buf_set_option :omnifunc "v:lua.vim.lsp.omnifunc"))

  (when client.server_capabilities.documentFormattingProvider
    (buf_key_map :n :<leader>lf vim.lsp.buf.format))

  (when client.server_capabilities.documentRangeFormattingProvider
    (buf_key_map :v :<leader>lf vim.lsp.buf.range_formatting))

  (when client.server_capabilities.callHierarchyProvider
    (buf_key_map :n :<leader>ii vim.lsp.buf.incoming_calls)
    (buf_key_map :n :<leader>io vim.lsp.buf.outgoing_calls))

  (when client.server_capabilities.documentSymbolProvider
    (buf_key_map :n :<leader>lw vim.lsp.buf.document_symbol))

  (when client.server_capabilities.workspaceSymbolProvider
    (buf_key_map :n :<leader>lW vim.lsp.buf.workspace_symbol))

  (buf_key_map :n :gd vim.lsp.buf.definition)
  (buf_key_map :n :gD vim.lsp.buf.declaration)
  (buf_key_map :n :gi vim.lsp.buf.implementation)
  (buf_key_map :n :gr (fn [] (vim.lsp.buf.references {:includeDeclaration false})))
  (buf_key_map :n :K vim.lsp.buf.hover)
  (buf_key_map :n :<leader>lr vim.lsp.buf.rename)

  (when client.server_capabilities.codeActionProvider
    (buf_key_map :n :<leader>la vim.lsp.buf.code_action)
    (buf_key_map :v :<leader>la vim.lsp.buf.range_code_action))

  (when (= client.name :ccls)
    (let [ccls (require "dotfiles.ccls")
          luamap util.luamap]
      (luamap :n :<C-k> (fn [] (ccls.navigate :L)))
      (luamap :n :<C-j> (fn [] (ccls.navigate :R)))
      (luamap :n :<C-l> (fn [] (ccls.navigate :D)))
      (luamap :n :<C-h> (fn [] (ccls.navigate :U)))
      ;; ccla call
      (luamap :n :<space>ii (fn [] (ccls.call :caller)))
      (luamap :n :<space>io (fn [] (ccls.call :callee)))
      ;; ccls var
      (luamap :n :<space>vf (fn [] (ccls.ccls_var :field)))
      (luamap :n :<space>vl (fn [] (ccls.ccls_var :local)))
      (luamap :n :<space>vp (fn [] (ccls.ccls_var :parameter)))
      ;; ccls member
      (luamap :n :<space>mv (fn [] (ccls.member :variables)))
      (luamap :n :<space>mf (fn [] (ccls.member :functions)))
      (luamap :n :<space>mt (fn [] (ccls.member :types)))
      ;; ccls inheritance
      (luamap :n :<space>ib (fn [] (ccls.inheritance :base)))
      (luamap :n :<space>id (fn [] (ccls.inheritance :derived)))
      ;; ccls references extend
      (luamap :n :<space>gw (fn [] (ccls.extend_ref :write)))
      (luamap :n :<space>gr (fn [] (ccls.extend_ref :read)))
      (luamap :n :<space>gm (fn [] (ccls.extend_ref :macro)))
      (luamap :n :<space>gn (fn [] (ccls.extend_ref :notcall)))))

  (when client.server_capabilities.codeLensProvider
    (vim.api.nvim_create_autocmd [:BufEnter :CursorHold :InsertLeave]
                                 {:buffer bufnr
                                  :callback vim.lsp.codelens.refresh})
    (buf_key_map :n :<space>ll vim.lsp.codelens.run))

  (when client.server_capabilities.documentHighlightProvider
    (vim.api.nvim_create_autocmd [:CursorHold]
                                 {:buffer bufnr
                                  :callback vim.lsp.buf.document_highlight})
    (vim.api.nvim_create_autocmd [:CursorMoved :InsertEnter :WinLeave]
                                 {:buffer bufnr
                                  :callback vim.lsp.buf.clear_references})))

(tset vim.lsp.handlers "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border :single}))
(tset vim.lsp.handlers "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border :single}))

(let [(ok? lsp) (pcall require :lspconfig)
      capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))
      servers [:hls :ocamllsp]]
  (when ok?
    (each [_ name (ipairs servers)]
      (let [{name config} lsp]
        (config.setup
          {:on_attach on_attach
           :capabilities capabilities
           :flags {:debounce_text_changes 50}})))
    (lsp.sumneko_lua.setup
      {:on_attach on_attach
       :capabilities capabilities
       :cmd ["/home/rhcher/workspace/lua-language-server/bin/lua-language-server"]
       :settings {:Lua {:diagnostics {:enable true :globals [:vim :packer_plugins]}
                        :completion {:callSnippet :Replace}
                        :runtime {:version :LuaJIT}
                        :IntelliSense {:traceLocalSet true
                                       :traceReturn true
                                       :traceBeSetted true
                                       :traceFieldInject true}
                        :telemetry {:enable false}}}}
      :flags {:debounce_text_changes 50})
    (lsp.ccls.setup
      {:on_attach on_attach
       :capabilities capabilities
       :filetypes [:c :cpp :objectc]
       :cmd [:ccls]
       :init_options {:capabilities {:foldingRangeProvider true
                                     :workspace {:wordspaceFolders {:support true}}}
                      :index {:onChange false
                              :initialNoLinkage true}
                      :cache {:directory "/tmp/ccls-cache/"}
                      :xref {:maxNum 20000}}
       :flags {:debounce_text_changes 50}})
    ;; (lsp.clangd.setup
    ;;   {:on_attach on_attach
    ;;    :capabilities capabilities
    ;;    :cmd [:clangd
    ;;          :--clang-tidy
    ;;          :--background-index
    ;;          :--header-insertion=iwyu
    ;;          :--completion-style=detailed
    ;;          "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*"
    ;;          :--cross-file-rename]
    ;;    :flags {:debounce_text_changes 50}})
    (lsp.pylsp.setup
      {:on_attach on_attach
       :capabilities capabilities
       :filetypes [:python]
       :settings {:pylsp {:plugins {:pylint {:enabled false
                                             :executable :pylint}
                                    :pyflakes {:enabled false}
                                    :pycodestyle {:enabled false}
                                    :jedi_completion {:enabled true
                                                      :fuzzy false
                                                      :include_params false
                                                      :include_class_objects true
                                                      :eager true}
                                    :pyls_isort {:enabled true}
                                    :pylsp_mypy {:enabled true}}}}
       :flags {:debounce_text_changes 50}})))
