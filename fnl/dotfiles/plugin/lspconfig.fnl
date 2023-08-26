(local {: autoload} (require "nfnl.module"))
(local cmplsp (autoload "cmp_nvim_lsp"))
(local protocol (autoload "vim.lsp.protocol"))
(local a (autoload "nfnl.core"))
(import-macros {: autocmd : augroup : map} "dotfiles.macros")

(autocmd :LspAttach
  {:callback
   (fn [args]
     (let [bufnr args.buf
           ms protocol.Methods
           client (vim.lsp.get_client_by_id args.data.client_id)]
       (when (and (client.supports_method ms.textDocument_formatting)
                  (client.supports_method ms.textDocument_rangeFormatting))
         (map [:n :v] :<leader>lf #(vim.lsp.buf.format {:async true})))

       (when (client.supports_method ms.textDocument_prepareCallHierarchy)
         (map :n :<leader>ii vim.lsp.buf.incoming_calls)
         (map :n :<leader>io vim.lsp.buf.outgoing_calls))

       (when (client.supports_method ms.textDocument_documentSymbol)
         (map :n :<leader>lw vim.lsp.buf.document_symbol))

       (when (client.supports_method ms.workspace_symbol)
         (map :n :<leader>lW vim.lsp.buf.workspace_symbol))

       (when (client.supports_method ms.textDocument_codeAction)
         (map [:n :v] :<leader>la "<cmd>Lspsaga code_action<CR>"))

       (when (client.supports_method ms.textDocument_codeLens)
         (autocmd [:BufEnter :CursorHold :InsertLeave]
                  {:buffer bufnr
                   :callback vim.lsp.codelens.refresh})
         (when (client.supports_method ms.workspace_executeCommand)
           (map :n :<leader>ll vim.lsp.codelens.run)))

       (when (client.supports_method ms.textDocument_inlayHint)
         (let [(ok err) (pcall vim.lsp.inlay_hint bufnr true)]
           (when (not ok)
             (vim.print err))))

       (map :n :gd vim.lsp.buf.definition)
       (map :n :gD vim.lsp.buf.declaration)
       (map :n :gi vim.lsp.buf.implementation)
       (map :n :gr #(vim.lsp.buf.references {:includeDeclaration false}))
       (map :n :K #(let [ufo (require :ufo)
                            lspsaga_hover (require :lspsaga.hover)
                            winid (ufo.peekFoldedLinesUnderCursor)]
                        (when (not winid)
                          (vim.lsp.buf.hover))))
                          ; (: lspsaga_hover "render_hover_doc" {}))))
       (map :n :<leader>k "<cmd>Lspsaga hover_doc ++keep<CR>")
       (map :n :<leader>lr ":Lspsaga rename<CR>")

       (let [delete-empty-lsp-clients #(let [clients (vim.lsp.get_clients)]
                                         (each [_ client (ipairs clients)]
                                           (local bufs (vim.lsp.get_buffers_by_client_id client.id))
                                           (when (= (length bufs) 0)
                                             (print (.. "stopping LSP server " client.name))
                                             (client:stop))))]
         (augroup "LspTimeOut"
           [["BufDelete"] {:pattern "*"
                           :callback #(vim.defer_fn delete-empty-lsp-clients 5000)}]))))})

(tset vim.lsp.handlers "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border :single :title "hover" :title_pos "left"}))
;; (tset vim.lsp.handlers "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border :single}))

(local ccls_config
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

(fn ccls_on_attach [_ _]
  (let [ccls (require "dotfiles.ccls")]
    ;; ccls navigate
    (map :n :<C-k> #(ccls.navigate :L))
    (map :n :<C-j> #(ccls.navigate :R))
    (map :n :<C-l> #(ccls.navigate :D))
    (map :n :<C-h> #(ccls.navigate :U))
    ;; ccls call
    (map :n :<space>ii #(ccls.call :caller))
    (map :n :<space>io #(ccls.call :callee))
    ;; ccls var
    (map :n :<space>vf #(ccls.ccls_var :field))
    (map :n :<space>vl #(ccls.ccls_var :local))
    (map :n :<space>vp #(ccls.ccls_var :parameter))
    ;; ccls member
    (map :n :<space>mv #(ccls.member :variables))
    (map :n :<space>mf #(ccls.member :functions))
    (map :n :<space>mt #(ccls.member :types))
    ;; ccls inheritance#
    (map :n :<space>ib #(ccls.inheritance :base))
    (map :n :<space>id #(ccls.inheritance :derived))
    ;; ccls references #
    (map :n :<space>gw #(ccls.extend_ref :write))
    (map :n :<space>gr #(ccls.extend_ref :read))
    (map :n :<space>gm #(ccls.extend_ref :macro))
    (map :n :<space>gn #(ccls.extend_ref :notcall))
    ; ccls info
    (map :n :<space>cf #(ccls.ccls_fileInfo))
    (map :n :<space>ci #(ccls.ccls_info))))

(local sumneko_lua_config
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
         :format {:enable true
                  :defaultConfig {:indent_style :space
                                  :indent_size :2}}}})

(local pylsp_config
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

(local pyright_config
  {:python {:analysis {:autoSearchPaths true
                       :useLibraryCodeForTypes true
                       :diagnositcMode "workspace"}}})

(local hls_config
  {:haskell {:formattingProvider "ormolu"}})

(local vimls-config
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
      flags {:debounce_text_changes 50}]
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
    (lsp.pyright.setup
      {:capabilities capabilities
       :settings pyright_config
       :flags flags})))
