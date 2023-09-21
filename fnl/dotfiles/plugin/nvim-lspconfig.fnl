(local {: autoload} (require "nfnl.module"))
(local protocol (autoload "vim.lsp.protocol"))
(local a (autoload "nfnl.core"))
(import-macros {: map} "dotfiles.macros")

(local ccls_config
  {:capabilities {:foldingRangeProvider true
                  :workspace {:workspaceFolders {:supported false}}}
   :index {:threads (a.count (vim.loop.cpu_info))
           :initialNoLinkage true}
           ; :initialBlacklist ["/(clang|lld|llvm)/(test|unittests)/"
           ;                    "/llvm/(bindings|examples|utils)/"
           ;                    "/StaticAnalyzer/"]}
   :diagnostics {:onChange -1
                 :onOpen 1000
                 :onSave 50}
   :highlight {:lsRanges true}
   :cache {:directory "/tmp/ccls-cache/"}
   :xref {:maxNum 20000}})

(fn ccls_on_attach [_ bufnr]
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
    ; ccls semantic hightlight
    (tset vim.lsp.handlers "$ccls/publishSkippedRanges" ccls.skipped-ranges-handler)
    (tset vim.lsp.handlers "$ccls/publishSemanticHighlight" ccls.semantic-hightlight-handler)))

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
      flags {:debounce_text_changes 50}
      cmplsp (require "cmp_nvim_lsp")]
  (var capabilities (cmplsp.default_capabilities))
  (set capabilities.textDocument.foldingRange {:dynamicRegistration false
                                               :lineFoldingOnly true})

  (tset capabilities :workspace {:didChangeWatchedFiles {:dynamicRegistration false}})
  (when ok?
    ; (lsp.ccls.setup
    ;   {:on_attach ccls_on_attach
    ;    :capabilities capabilities
    ;    :init_options ccls_config
    ;    :flags flags})
    (lsp.clangd.setup
      {:capabilities capabilities
       :cmd [:clangd
             :--clang-tidy
             :--background-index
             :--completion-style=detailed
             "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*"
             :--cross-file-rename
             :--header-insertion=never]
       :flags flags})
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
