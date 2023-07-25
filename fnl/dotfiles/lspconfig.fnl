(module dotfiles.plugin.lspconfig
  {autoload {cmplsp cmp_nvim_lsp
             lsp_util vim.lsp.util
             a aniseed.core}
   import-macros [[{: autocmd : augroup} :aniseed.macros.autocmds]]})

(autocmd :LspAttach
  {:callback
   (fn [args]
     (let [bufnr args.buf
           client (vim.lsp.get_client_by_id args.data.client_id)
           keymap (fn [mode from to] (vim.keymap.set mode from to {:buffer bufnr :noremap true :silent true}))]
       (when client.server_capabilities.documentFormattingProvider
         (keymap [:n :v] :<leader>lf vim.lsp.buf.format {:async true}))

       (when client.server_capabilities.callHierarchyProvider
         (keymap :n :<leader>ii vim.lsp.buf.incoming_calls)
         (keymap :n :<leader>io vim.lsp.buf.outgoing_calls))

       (when client.server_capabilities.documentSymbolProvider
         (keymap :n :<leader>lw vim.lsp.buf.document_symbol))

       (when client.server_capabilities.workspaceSymbolProvider
         (keymap :n :<leader>lW vim.lsp.buf.workspace_symbol))

       (when client.server_capabilities.codeActionProvider
         (keymap [:n :v] :<leader>la "<cmd>Lspsaga code_action<CR>"))

       (when client.server_capabilities.codeLensProvider
         (autocmd [:BufEnter :CursorHold :InsertLeave]
                  {:buffer bufnr
                   :callback vim.lsp.codelens.refresh})
         (keymap :n :<leader>ll vim.lsp.codelens.run))

       (when client.server_capabilities.inlayHintProvider
         (let [(ok err) (pcall vim.lsp.inlay_hint bufnr true)]
           (when (not ok)
             (vim.print err))))

       (keymap :n :gd vim.lsp.buf.definition)
       (keymap :n :gD vim.lsp.buf.declaration)
       (keymap :n :gi vim.lsp.buf.implementation)
       (keymap :n :gr #(vim.lsp.buf.references {:includeDeclaration false}))
       (keymap :n :K #(let [ufo (require :ufo)
                            lspsaga_hover (require :lspsaga.hover)
                            winid (ufo.peekFoldedLinesUnderCursor)]
                        (when (not winid)
                          (vim.lsp.buf.hover))))
                          ; (: lspsaga_hover "render_hover_doc" {}))))
       (keymap :n :<leader>k "<cmd>Lspsaga hover_doc ++keep<CR>")
       (keymap :n :<leader>lr ":Lspsaga rename<CR>")

       (let [delete-empty-lsp-clients #(let [clients (vim.lsp.get_active_clients)]
                                         (each [_ client (ipairs clients)]
                                           (local bufs (vim.lsp.get_buffers_by_client_id client.id))
                                           (when (= (length bufs) 0)
                                             (print (.. "stopping LSP server " client.name))
                                             (client:stop))))]
         (augroup "LspTimeOut"
           [["BufDelete"] {:pattern "*"
                           :callback #(vim.defer_fn delete-empty-lsp-clients 5000)}]))

       (let [lsp-cancel-pending-requests (fn [bufnr]
                                           (vim.schedule #(let [bufnr (if (or (= bufnr nil) (= bufnr 0))
                                                                        (vim.api.nvim_get_current_buf)
                                                                        bufnr)]
                                                            (each [_ client (ipairs (vim.lsp.get_active_clients {:bufnr bufnr}))]
                                                              (each [id request (pairs (or client.requests {}))]
                                                                (when (and (= request.type "pending")
                                                                           (= request.bufnr bufnr)
                                                                           (not (request.method:match "semanticTokens")))
                                                                  (client.cancel_request id)))))))]
         (augroup "LspCancelRequest"
           [["BufLeave"] {:buffer bufnr
                          :callback #(lsp-cancel-pending-requests)
                          :desc "lsp.cancel_pending_requests"}]))))})

(tset vim.lsp.handlers "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border :single :title "hover" :title_pos "left"}))
;; (tset vim.lsp.handlers "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border :single}))

(def ccls_config
  {:capabilities {:foldingRangeProvider true
                  :workspace {:workspaceFolders {:supported false}}}
   :index {:threads (a.count (vim.loop.cpu_info))
           :initialNoLinkage true
           :initialBlacklist ["/(clang|lld|llvm)/(test|unittests)/"
                              "/llvm/(bindings|examples|utils)/"
                              "/StaticAnalyzer/"]}
   :diagnostics {:onChange -1
                 :onOpen 1000
                 :onSave 50}
   :highlight {:lsRanges true}
   :cache {:directory "/tmp/ccls-cache/"}
   :xref {:maxNum 20000}})

(defn- ccls_on_attach [client bufnr]
  (let [ccls (require "dotfiles.ccls")
        keymap (fn [mode from to] (vim.keymap.set mode from to {:buffer bufnr :noremap true :silent true}))]
    ;; ccls navigate
    (keymap :n :<C-k> #(ccls.navigate :L))
    (keymap :n :<C-j> #(ccls.navigate :R))
    (keymap :n :<C-l> #(ccls.navigate :D))
    (keymap :n :<C-h> #(ccls.navigate :U))
    ;; ccls call
    (keymap :n :<space>ii #(ccls.call :caller))
    (keymap :n :<space>io #(ccls.call :callee))
    ;; ccls var
    (keymap :n :<space>vf #(ccls.ccls_var :field))
    (keymap :n :<space>vl #(ccls.ccls_var :local))
    (keymap :n :<space>vp #(ccls.ccls_var :parameter))
    ;; ccls member
    (keymap :n :<space>mv #(ccls.member :variables))
    (keymap :n :<space>mf #(ccls.member :functions))
    (keymap :n :<space>mt #(ccls.member :types))
    ;; ccls inheritance#
    (keymap :n :<space>ib #(ccls.inheritance :base))
    (keymap :n :<space>id #(ccls.inheritance :derived))
    ;; ccls references #
    (keymap :n :<space>gw #(ccls.extend_ref :write))
    (keymap :n :<space>gr #(ccls.extend_ref :read))
    (keymap :n :<space>gm #(ccls.extend_ref :macro))
    (keymap :n :<space>gn #(ccls.extend_ref :notcall))
    ; ccls info
    (keymap :n :<space>cf #(ccls.ccls_fileInfo))
    (keymap :n :<space>ci #(ccls.ccls_info))))

(def sumneko_lua_config
  {:Lua {:diagnostics {:enable true :globals [:vim]}
         :completion {:callSnippet :Replace
                      :showWord :Disable}
         :hint {:enable true}
         :runtime {:version :LuaJIT}
         :workspace {:checkThirdParty false}
         :IntelliSense {:traceLocalSet true
                        :traceReturn true
                        :traceBeSetted true
                        :traceFieldInject true}
         :telemetry {:enable false}
         :format {:enable true
                  :defaultConfig {:indent_style :space
                                  :indent_size :2}}}})

(def- pylsp_config
  {:pylsp {:plugins {:pylint {:enabled false
                              :executable :pylint}
                     :pyflakes {:enabled false}
                     :pycodestyle {:enabled false}
                     :jedi_completion {:enabled true
                                       :fuzzy false
                                       :include_params false
                                       :include_class_objects true
                                       :eager true}
                     :pyls_isort {:enabled true}
                     :pylsp_mypy {:enabled true}}}})

(def- pyright_config
  {:python {:analysis {:autoSearchPaths true
                       :useLibraryCodeForTypes true
                       :diagnositcMode "workspace"}}})

(def- hls_config
  {:haskell {:formattingProvider "ormolu"}})

(def- vimls-config
  {:diagnositc {:enable true}
   :indexes {:count 3
             :gap 100
             :projectRootPatterns ["runtime" "nvim" ".git" "autoload" "plugin"]
             :runtimepath true}
   :isNeovim true
   :isKeyword "@,48-57,_,192-255,-#"
   :runtimepath ""
   :suggest {:fromRuntimepath true
             :fromVimruntime true}
   :vimruntime ""})

(let [(ok? lsp) (pcall require "lspconfig")
      flags {:debounce_text_changes 50}
      neodev (require "neodev")]
  (neodev.setup)
  (var capabilities (cmplsp.default_capabilities))
  (set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                               :lineFoldingOnly true})

  (tset capabilities :workspace {:didChangeWatchedFiles {:dynamicRegistration false}})
  (when ok?
    (lsp.ccls.setup
      {:on_attach ccls_on_attach
       :capabilities capabilities
       :init_options ccls_config
       :flags flags})
    ; (lsp.clangd.setup
    ;   {:on_attach on_attach
    ;    :capabilities capabilities
    ;    :cmd [:clangd
    ;          :--clang-tidy
    ;          :--background-index
    ;          :--completion-style=detailed
    ;          "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*"
    ;          :--cross-file-rename
    ;          :--header-insertion=never]
    ;    :flags flags})
    (lsp.lua_ls.setup
      {:capabilities capabilities
       :cmd ["/home/rhcher/sources/lua-language-server/bin/lua-language-server"]
       :settings sumneko_lua_config
       :flags flags})
    (lsp.ocamllsp.setup
      {:capabilities capabilities
       :flags flags})
    (lsp.vimls.setup
      {:capabilities capabilities
       :flags flags})
    (lsp.hls.setup
      {:capabilities capabilities
       :settings hls_config
       :flags flags})
    (lsp.racket_langserver.setup
      {:capabilities capabilities
       :flags flags})
    ; (lsp.pylyzer.setup
    ;   {:capabilities capabilities
    ;    :flags flags})
    (lsp.pyright.setup
      {:capabilities capabilities
       :settings pyright_config
       :flags flags})))
