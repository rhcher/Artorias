(import-macros {: autocmd : augroup : map} "config.macros")
(local {: autoload} (require "nfnl.module"))
(local a (autoload "nfnl.core"))
(local protocol (autoload "vim.lsp.protocol"))

(autocmd :LspAttach
         {:callback
          (fn [args]
            (let [bufnr args.buf
                  ms protocol.Methods
                  client (vim.lsp.get_client_by_id args.data.client_id)]
              (when (and (client:supports_method ms.textDocument_formatting)
                         (client:supports_method ms.textDocument_rangeFormatting))
                (map [:n :v] :<leader>lf #(vim.lsp.buf.format {:async true}) {:buffer bufnr}))

              (when (client:supports_method ms.textDocument_prepareCallHierarchy)
                (map :n :<leader>ii vim.lsp.buf.incoming_calls {:buffer bufnr})
                (map :n :<leader>io vim.lsp.buf.outgoing_calls {:buffer bufnr}))

              (when (client:supports_method ms.textDocument_documentSymbol)
                (map :n :<leader>lw "<cmd>Lspsaga outline<CR>" {:buffer bufnr}))
              ; (map :n :<leader>lw vim.lsp.buf.document_symbol {:buffer bufnr}))

              (when (client:supports_method ms.workspace_symbol)
                (map :n :<leader>lW vim.lsp.buf.workspace_symbol {:buffer bufnr}))

              (when (client:supports_method ms.textDocument_codeAction)
                (map [:n :v] :<leader>la vim.lsp.buf.code_action {:buffer bufnr}))
              ;(map [:n :v] :<leader>la "<cmd>Lspsaga code_action<CR>" {:buffer bufnr}))

              (when (client:supports_method ms.textDocument_codeLens)
                (autocmd [:BufEnter :CursorHold :InsertLeave]
                         {:buffer bufnr
                          :callback #(vim.lsp.codelens.enable true)})
                (when (client:supports_method ms.workspace_executeCommand)
                  (map :n :<leader>ll vim.lsp.codelens.run {:buffer bufnr})))

              ; (when (client:supports_method ms.textDocument_inlayHint)
              ;   (vim.lsp.inlay_hint.enable 0 true)
              ;   (autocmd ["InsertLeave"] {:buffer bufnr :callback #(vim.defer_fn #(vim.lsp.inlay_hint.enable 0 true) 1000)})
              ;   (autocmd ["InsertEnter"] {:buffer bufnr :callback #(vim.lsp.inlay_hint.enable 0 false)}))

              (map :n :gd vim.lsp.buf.definition {:buffer bufnr})
              (map :n :gD vim.lsp.buf.declaration {:buffer bufnr})
              (map :n :gi vim.lsp.buf.implementation {:buffer bufnr})
              (map :n :gr #(vim.lsp.buf.references {:includeDeclaration false}) {:buffer bufnr})
              (map :n :K #(let [(_ ufo) (pcall require :ufo)
                                (_ lspsaga_hover) (pcall require :lspsaga.hover)
                                winid (ufo.peekFoldedLinesUnderCursor)]
                            (when (not winid)
                              (vim.lsp.buf.hover)))
                   {:buffer bufnr})
              ; (lspsaga_hover:render_hover_doc {}))) {:buffer bufnr})
              (map :n :<leader>k "<cmd>Lspsaga hover_doc ++keep<CR>" {:buffer bufnr})
              (map :n :<leader>lr ":Lspsaga rename<CR>" {:buffer bufnr})

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

(vim.lsp.config "*"
                {:root_markers [".git"]})

(vim.lsp.config "ccls"
                {:cmd ["ccls"]
                 :filetypes ["c" "cpp" "objc" "objcpp" "cuda"]
                 :root_markers ["compile_commands.json" ".ccls"]
                 :offset_encoding "utf-32"
                 :workspace_required true
                 :on_attach (fn [_ bufnr]
                              (let [ccls (require "dotfiles.ccls")]
                                ;; ccls navigate
                                (map :n :<C-k> #(ccls.navigate :L) {:buffer bufnr})
                                (map :n :<C-j> #(ccls.navigate :R) {:buffer bufnr})
                                (map :n :<C-l> #(ccls.navigate :D) {:buffer bufnr})
                                (map :n :<C-h> #(ccls.navigate :U) {:buffer bufnr})
                                ;; ccls call
                                (map :n :<space>ii #(ccls.call :caller) {:buffer bufnr})
                                (map :n :<space>io #(ccls.call :callee) {:buffer bufnr})
                                ;; ccls var
                                (map :n :<space>vf #(ccls.ccls_var :field) {:buffer bufnr})
                                (map :n :<space>vl #(ccls.ccls_var :local) {:buffer bufnr})
                                (map :n :<space>vp #(ccls.ccls_var :parameter) {:buffer bufnr})
                                ;; ccls member
                                (map :n :<space>mv #(ccls.member :variables) {:buffer bufnr})
                                (map :n :<space>mf #(ccls.member :functions) {:buffer bufnr})
                                (map :n :<space>mt #(ccls.member :types) {:buffer bufnr})
                                ;; ccls inheritance
                                (map :n :<space>ib #(ccls.inheritance :base) {:buffer bufnr})
                                (map :n :<space>id #(ccls.inheritance :derived) {:buffer bufnr})
                                ;; ccls references
                                (map :n :<space>gw #(ccls.extend_ref :write) {:buffer bufnr})
                                (map :n :<space>gr #(ccls.extend_ref :read) {:buffer bufnr})
                                (map :n :<space>gm #(ccls.extend_ref :macro) {:buffer bufnr})
                                (map :n :<space>gn #(ccls.extend_ref :notcall) {:buffer bufnr})
                                ; ccls info
                                (map :n :<space>cf #(ccls.ccls_fileInfo) {:buffer bufnr})
                                (map :n :<space>ci #(ccls.ccls_info) {:buffer bufnr})
                                ; ; ccls semantic hightlight
                                (tset vim.lsp.handlers "$ccls/publishSkippedRanges" ccls.skipped-ranges-handler)
                                (tset vim.lsp.handlers "$ccls/publishSemanticHighlight" ccls.semantic-hightlight-handler)))
                 :init_options {:capabilities {:foldingRangeProvider true}
                                :workspace {:workspaceFolders {:supported false}}
                                :clang {:excludeArgs ["-fconserve-stack"
                                                      "-fno-allow-store-data-races"
                                                      "-Wp"
                                                      "-MMD"
                                                      "-fomit-frame-pointer"
                                                      "-Wmissing-prototypes"
                                                      "-Wstrict-prototypes"]}
                                :index {:threads (a.count (vim.loop.cpu_info))
                                        :initialNoLinkage true
                                        :initialBlacklist ["/(clang|lld|llvm)/(test|unittests)/"
                                                           "/llvm/(bindings|examples|utils)/"
                                                           "/StaticAnalyzer/"]}
                                :diagnostics {:onChange -1
                                              :onOpen 1000
                                              :onSave 50}
                                :highlight {:lsRanges true}
                                :cache {:retainInMemory 1
                                        :directory "/tmp/ccls-cache/"}
                                :xref {:maxNum 20000}}})

(vim.lsp.config "clangd"
                {:cmd [:clangd
                       :--clang-tidy
                       :--background-index
                       :--completion-style=detailed
                       "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*"
                       :--cross-file-rename
                       :--header-insertion=never]
                 :filetypes ["c" "cpp" "objc" "objcpp" "cuda" "proto"]
                 :root_markers ["compile_commands.json" ".clangd" ".clang-format" "compile_flags.txt"]
                 :capabilities {:textDocument {:completion {:editsNearCursor true}}
                                :offsetEncoding ["utf-8" "utf-16"]}
                 :reuse_client (fn [client config] (= client.name config.name))})

(vim.lsp.config "lua_ls"
                {:cmd ["lua-language-server"]
                 :filetypes ["lua"]
                 :root_markers [".luarc.json" ".luarc.jsonc" ".luacheckrc" ".stylua.toml" "stylua.toml" "selene.toml" "selene.yml"]})

(vim.lsp.config "emmylua_ls"
                {:cmd ["emmylua_ls"]
                 :filetypes ["lua"]
                 :root_markers [".luarc.json" ".emmyrc.json" ".luacheckrc" ".git"]
                 :workspace_required false})

(vim.lsp.config "clice"
                {:cmd ["/home/rhcher/source/clice/clice" "--resource-dir=/usr/lib/clang/20/"]
                 :filetypes ["c" "cpp"]
                 :root_markers ["compile_commands.json" ".clang-format"]})

(vim.lsp.config "basedpyright"
                {:cmd ["basedpyright-langserver" "--stdio"]
                 :filetypes ["python"]
                 :root_markers ["pyproject.toml" "setup.py" "requirements.txt"]
                 :settings {:basedpyright {:analysis {:autoSearchPaths true
                                                      :useLibraryCodeForTypes true
                                                      :diagnosticMode "openFilesOnly"}}}})

(vim.lsp.enable ["clangd" "lua_ls" "basedpyright"])
