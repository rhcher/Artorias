(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             cmplsp cmp_nvim_lsp
             lsp_util vim.lsp.util
             a aniseed.core
             saga lspsaga}})

(saga.init_lsp_saga {:code_action_lightbulb {:sign_priority 99
                                             :virtual_text false}})

(vim.api.nvim_create_autocmd
  :LspAttach
  {:callback (fn [args]
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
                 (keymap :n :gd vim.lsp.buf.definition)
                 (keymap :n :gD vim.lsp.buf.declaration)
                 (keymap :n :gi vim.lsp.buf.implementation)
                 (keymap :n :gr (fn [] (vim.lsp.buf.references {:includeDeclaration false})))
                 (keymap :n :K vim.lsp.buf.hover)
                 (keymap :n :<leader>lr ":Lspsaga rename<CR>")

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
                      (map :n :<space>gn (fn [] (ccls.extend_ref :notcall)))))))})

(tset vim.lsp.handlers "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border :single}))
(tset vim.lsp.handlers "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border :single}))

(def- ccls_config
  {:capabilities {:foldingRangeProvider true
                  :workspace {:wordspaceFolders {:support true}}}
   :index {:onChange false
           :threads (a.count (vim.loop.cpu_info))
           :initialNoLinkage true
           :maxInitializerLines 50
           :initialBlacklist ["/(clang|lld|llvm)/(test|unittests)/"
                              "/llvm/(bindings|examples|utils)/"
                              "/StaticAnalyzer/"]}
   :diagnostics {:onChange -1
                 :onOpen 1000
                 :onSave 50}
   :highlight {:lsRanges true}
   :cache {:directory "/tmp/ccls-cache/"}
   :xref {:maxNum 20000}})

(def- sumneko_lua_config
  {:Lua {:diagnostics {:enable true :globals [:vim]}
         :completion {:callSnippet :Replace}
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

(def- hls_config
  {:haskell {:formattingProvider "ormolu"}})

(let [root-pattern (fn [patterns]
                     (vim.fs.dirname
                       (. (vim.fs.find patterns {:upward true}) 1)))
      callback (fn [lsp-config] (vim.lsp.start lsp-config))]
  (var capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities)))
  (set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                               :lineFoldingOnly true})
  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern [:c :cpp]
     :callback
     (fn [] (vim.lsp.start
               {:name "ccls"
                :cmd ["ccls"]
                :capabilities capabilities
                :init_options ccls_config
                :root_dir (root-pattern [".ccls" "compile-commands.json" ".ccls-root" ".git"])
                :flags {:debounce_text_changes 20}}))})

  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern [:lua]
     :callback
     (fn [] (vim.lsp.start
              {:name "sumneko_lua"
               :cmd ["/home/rhcher/sources/lua-language-server/bin/lua-language-server"]
               :capabilities capabilities
               :settings sumneko_lua_config
               :root_dir (root-pattern [".luarc.json" ".luacheckrc" ".stylua.toml" "stylua.toml" "selene.toml" ".git"])
               :single_file_support true}))})

  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern [:python]
     :callback
     (fn [] (vim.lsp.start
              {:name "pylsp"
               :cmd ["pylsp"]
               :capabilities capabilities
               :settings pylsp_config
               :root_dir (root-pattern [".git"])
               :single_file_support true}))})
  ;;
  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern [:haskell :lhaskell]
     :callback
     (fn [] (vim.lsp.start
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
               :single_file_support true}))})

  (vim.api.nvim_create_autocmd
    :FileType
    {:pattern [:ocaml :ocaml.menhir :ocaml.interface :ocaml.ocamllex :reason :dune]
     :callback
     (fn [] (vim.lsp.start
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
                                    (. language_id_of ftype)))}))}))
