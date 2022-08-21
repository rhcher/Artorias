(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             cmplsp cmp_nvim_lsp
             lsp_util vim.lsp.util
             utils lspconfig.util
             a aniseed.core
             saga lspsaga}})

(saga.init_lsp_saga {:code_action_lightbulb {:sign_priority 99
                                             :virtual_text false}})

(defn- on_attach [client bufnr]

  (defn- buf_key_map [mode from to]
    (vim.keymap.set mode from to {:buffer bufnr :noremap true :silent true}))

  (when client.server_capabilities.documentFormattingProvider
    (buf_key_map :n :<leader>lf vim.lsp.buf.format {:async true}))

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
  ;; (buf_key_map :n :<leader>lr vim.lsp.buf.rename)
  (buf_key_map :n :<leader>lr ":Lspsaga rename<CR>")

  (when client.server_capabilities.codeActionProvider
    ;; (buf_key_map :n :<leader>la vim.lsp.buf.code_action)
    ;; (buf_key_map :v :<leader>la vim.lsp.buf.range_code_action))
    (buf_key_map :n :<leader>la ":Lspsaga code_action<CR>")
    (buf_key_map :v :<leader>la ":<C-U>Lspsaga range_code_action<CR>"))

  (when (= client.name :ccls)
    (let [ccls (require "dotfiles.ccls")
          map util.luamap]
      (map :n :<C-k> (fn [] (ccls.navigate :L)))
      (map :n :<C-j> (fn [] (ccls.navigate :R)))
      (map :n :<C-l> (fn [] (ccls.navigate :D)))
      (map :n :<C-h> (fn [] (ccls.navigate :U)))
      ;; ccla call
      (map :n :<space>ii (fn [] (ccls.call :caller)))
      (map :n :<space>io (fn [] (ccls.call :callee)))
      ;; ccls var
      (map :n :<space>vf (fn [] (ccls.ccls_var :field)))
      (map :n :<space>vl (fn [] (ccls.ccls_var :local)))
      (map :n :<space>vp (fn [] (ccls.ccls_var :parameter)))
      ;; ccls member
      (map :n :<space>mv (fn [] (ccls.member :variables)))
      (map :n :<space>mf (fn [] (ccls.member :functions)))
      (map :n :<space>mt (fn [] (ccls.member :types)))
      ;; ccls inheritance
      (map :n :<space>ib (fn [] (ccls.inheritance :base)))
      (map :n :<space>id (fn [] (ccls.inheritance :derived)))
      ;; ccls references extend
      (map :n :<space>gw (fn [] (ccls.extend_ref :write)))
      (map :n :<space>gr (fn [] (ccls.extend_ref :read)))
      (map :n :<space>gm (fn [] (ccls.extend_ref :macro)))
      (map :n :<space>gn (fn [] (ccls.extend_ref :notcall)))))

  (when client.server_capabilities.codeLensProvider
    (vim.api.nvim_create_autocmd [:BufEnter :CursorHold :InsertLeave]
                                 {:buffer bufnr
                                  :callback vim.lsp.codelens.refresh})
    (buf_key_map :n :<space>ll vim.lsp.codelens.run))

  ;; (when client.server_capabilities.documentHighlightProvider
  ;;   (vim.api.nvim_create_augroup :lsp_document_highlight {:clear false})
  ;;   (vim.api.nvim_clear_autocmds {:buffer bufnr
  ;;                                 :group :lsp_document_highlight})
  ;;   (vim.api.nvim_create_autocmd [:CursorHold]
  ;;                                {:group :lsp_document_highlight
  ;;                                 :buffer bufnr
  ;;                                 :callback vim.lsp.buf.document_highlight})
  ;;   (vim.api.nvim_create_autocmd [:CursorMoved :InsertEnter :WinLeave]
  ;;                                {:group :lsp_document_highlight
  ;;                                 :buffer bufnr
  ;;                                 :callback vim.lsp.buf.clear_references})))

(tset vim.lsp.handlers "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border :single}))
(tset vim.lsp.handlers "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border :single}))

(let [(ok? lsp) (pcall require :lspconfig)
      servers [:hls :ocamllsp :bashls :rust_analyzer]]
  (var capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities)))
  (set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                               :lineFoldingOnly true})
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
       :cmd ["/home/rhcher/sources/lua-language-server/bin/lua-language-server"]
       :settings {:Lua {
                        :diagnostics {:enable true :globals [:vim]}
                        :completion {:callSnippet :Replace}
                        :runtime {:version :LuaJIT}
                        :IntelliSense {:traceLocalSet true
                                       :traceReturn true
                                       :traceBeSetted true
                                       :traceFieldInject true}
                        :telemetry {:enable false}
                        :format {:enable true
                                 :defaultConfig {:indent_style :space
                                                 :indent_size :2}}}}}
      :flags {:debounce_text_changes 50})
    (lsp.ccls.setup
      {:on_attach on_attach
       :capabilities capabilities
       :filetypes [:c :cpp :objc :objcpp]
       :cmd [:ccls]
       :init_options {:capabilities {:foldingRangeProvider true
                                     :workspace {:wordspaceFolders {:support true}}}
                      :highlight {:lsRanges true}
                      :index {:onChange false
                              :threads (a.count (vim.loop.cpu_info))
                              :initialNoLinkage true
                              :initialBlacklist ["/(clang|lld|llvm)/(test|unittests)/"
                                                 "/llvm/(bindings|examples|utils)/"
                                                 "/StaticAnalyzer/"]}
                      :highlight {:lsRanges true}
                      :cache {:directory "/tmp/ccls-cache/"}
                      :xref {:maxNum 20000}}
       :flags {:debounce_text_changes 50}})
    ;; (lsp.clangd.setup
    ;;   {:on_attach on_attach
    ;;    :capabilities capabilities
    ;;    :cmd [:clangd
    ;;          :--clang-tidy
    ;;          :--background-index
    ;;          :--completion-style=detailed
    ;;          "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*"
    ;;          :--cross-file-rename
    ;;          :--header-insertion=never
    ;;          :--pch-storage=disk]
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
