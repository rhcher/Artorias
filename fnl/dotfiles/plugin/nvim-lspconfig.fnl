; (local {: autoload} (require "nfnl.module"))
; (local protocol (autoload "vim.lsp.protocol"))
; (local a (autoload "nfnl.core"))
; (import-macros {: map} "dotfiles.macros")
;
; (local sumneko_lua_config
;   {:Lua {:diagnostics {:enable true :globals [:vim]}
;          :completion {:callSnippet :Replace
;                       :showWord :Disable}
;          :hint {:enable true}
;          :runtime {:version :LuaJIT}
;          :workspace {:checkThirdParty false
;                      :library [vim.env.VIMRUNTIME]}
;          :IntelliSense {:traceLocalSet true
;                         :traceReturn true
;                         :traceBeSetted true
;                         :traceFieldInject true}
;          :format {:enable true
;                   :defaultConfig {:indent_style :space
;                                   :indent_size :2}}}})
;
; (local pylsp_config
;   {:pylsp {:plugins {:pylint {:enabled false
;                               :executable :pylint}
;                      :pyflakes {:enabled false}
;                      :pycodestyle {:enabled false}
;                      :jedi_completion {:enabled true
;                                        :fuzzy false
;                                        :include_params false
;                                        :include_class_objects true
;                                        :eager true}
;                      :pyls_isort {:enabled true}
;                      :pylsp_mypy {:enabled true}}}})
;
; (local pyright_config
;   {:python {:analysis {:autoSearchPaths true
;                        :useLibraryCodeForTypes true
;                        :diagnositcMode "workspace"}}})
;
; (local hls_config
;   {:haskell {:formattingProvider "ormolu"}})
;
; (local vimls-config
;   {:diagnositc {:enable true}
;    :indexes {:count 3
;              :gap 100
;              :projectRootPatterns ["runtime" "nvim" ".git" "autoload" "plugin"]
;              :runtimepath true}
;    :isNeovim true
;    :isKeyword "@,48-57,_,192-255,-#"
;    :runtimepath ""
;    :suggest {:fromRuntimepath true
;              :fromVimruntime true}
;    :vimruntime ""})
