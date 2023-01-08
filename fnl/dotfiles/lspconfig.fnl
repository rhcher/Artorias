(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             cmplsp cmp_nvim_lsp
             lsp_util vim.lsp.util
             semantic dotfiles.semanticTokens
             a aniseed.core}})

(when-let [(_ lspsaga) (pcall require "lspsaga")]
  (lspsaga.init_lsp_saga {:code_action_lightbulb {:sign_priority 99
                                                  :virtual_text false}}))

(vim.api.nvim_create_autocmd :LspAttach
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
         (vim.api.nvim_create_autocmd [:BufEnter :CursorHold :InsertLeave]
                                      {:buffer bufnr
                                       :callback vim.lsp.codelens.refresh})
         (keymap :n :<space>ll vim.lsp.codelens.run))

       (when (and client.server_capabilities.semanticTokensProvider client.server_capabilities.semanticTokensProvider.full)
         (let [aug (vim.api.nvim_create_augroup "SemanticTokens" {:clear true})]
           (vim.api.nvim_clear_autocmds {:group aug
                                         :buffer bufnr})
           (vim.api.nvim_create_autocmd [:BufEnter :InsertLeave :CursorHold]
                                        {:group aug
                                         :buffer bufnr
                                         :callback #(vim.lsp.buf.semantic_tokens_full)})))

       (keymap :n :gd vim.lsp.buf.definition)
       (keymap :n :gD vim.lsp.buf.declaration)
       (keymap :n :gi vim.lsp.buf.implementation)
       (keymap :n :gr #(vim.lsp.buf.references {:includeDeclaration false}))
       (keymap :n :K vim.lsp.buf.hover)
       (keymap :n :<leader>lr ":Lspsaga rename<CR>")

       (when (= client.name :ccls)
         (let [ccls (require "dotfiles.ccls")
               map util.luamap]
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
           (map :n :<space>gn #(ccls.extend_ref :notcall))))))})
           ;; (tset vim.lsp.handlers "$ccls/publishSemanticHighlight" ccls.semantic-hightlight-handler)
           ;; (tset vim.lsp.handlers "$ccls/publishSkippedRanges" ccls.skipped-ranges-handler)))))})

(tset vim.lsp.handlers "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border :single}))
(tset vim.lsp.handlers "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border :single :title "hover" :title_pos "left"}))
(tset vim.lsp.handlers "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border :single}))

(def ccls_config
  {:capabilities {:foldingRangeProvider true
                  :workspace {:wordspaceFolders {:support true}}}
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

(def sumneko_lua_config
  {:Lua {:diagnostics {:enable true :globals [:vim]}
         :completion {:callSnippet :Replace
                      :showWord :Disable}
         :runtime {:version :LuaJIT}
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

(def root-pattern (fn [patterns]
                    (vim.fs.dirname
                      (. (vim.fs.find patterns {:upward true}) 1))))

(def flags {:debounce_text_changes 50})

(defn capabilities []
  (var capabilities (cmplsp.default_capabilities))
  (set capabilities (semantic.extend-capabilities capabilities))
  (set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                               :lineFoldingOnly true})
  capabilities)

(defn safe-start [config]
  (let [bufnr (vim.api.nvim_get_current_buf)]
    (when (not= (vim.api.nvim_buf_get_option bufnr "buftype") "nofile")
      (config))))

(let [root-pattern (fn [patterns]
                     (vim.fs.dirname
                       (. (vim.fs.find patterns {:upward true}) 1)))
      flags {:debounce_text_changes 50}]
  (var capabilities (cmplsp.default_capabilities))
  (set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                               :lineFoldingOnly true})
  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern [:haskell :lhaskell]
     :callback #(vim.lsp.start
                  {:name "hls"
                   :cmd ["haskell-language-server-wrapper" "--lsp"]
                   :capabilities capabilities
                   :settings hls_config
                   :root_dir (root-pattern ["hie.yaml" "stack.yaml" "cabal.project" "*.cabal" "package.yaml"])
                   :lspinfo (fn [cfg]
                              (var extra [])
                              (let [on_stdout (fn [_ data _] (let [version (. data 1)] (table.insert extra (.. "version:   " version))))
                                    opts {:cwd cfg.cwd
                                          :stdout_buffered true
                                          :on_stdout on_stdout}
                                    chanid (vim.fn.jobstart [(. cfg.cmd 1) "--version"] opts)]
                                (vim.fn.jobwait [chanid]))
                              extra)
                   :single_file_support true
                   :flags flags})})

  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern [:ocaml :ocaml.menhir :ocaml.interface :ocaml.ocamllex :reason :dune]
     :callback #(vim.lsp.start
                  {:name "ocamllsp"
                   :cmd ["ocamllsp"]
                   :root_dir (root-pattern ["*.opam" "esy.json" "package.json" ".git" "dune-project" "dune-workspace"])
                   :get_language_id (fn [_ ftype]
                                      (let [language_id_of
                                            {:menhir :ocmal.menhir
                                             :ocaml :ocaml
                                             :ocamlinterface :ocaml.interface
                                             :ocamllex :ocaml.ocamllex
                                             :reason :reason
                                             :dune :dune}]
                                        (. language_id_of ftype)))
                   :flags flags})})

  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern [:vim]
     :callback #(vim.lsp.start
                  {:name "vimls"
                   :cmd ["vim-language-server" "--stdio"]
                   :root_dir (root-pattern [".git"])
                   :init_options vimls-config
                   :single_file_support true
                   :flags flags})}))
