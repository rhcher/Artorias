(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             nvim aniseed.nvim
             cmplsp cmp_nvim_lsp
             lsp_util vim.lsp.util
             utils lspconfig.util}})

(defn- on_attach [client bufnr]

  (defn- buf_key_map [mode from to]
    (vim.api.nvim_buf_set_keymap bufnr mode from (.. "<cmd>" to "<CR>") {:noremap true :silent true}))

  (defn- buf_set_option [...]
    (vim.api.nvim_buf_set_option bufnr ...))


  (when client.resolved_capabilities.completion
    (buf_set_option :omnifunc "v:lua.vim.lsp.omnifunc"))

  (buf_key_map :n :gd "lua vim.lsp.buf.definition()")
  (buf_key_map :n :gD "lua vim.lsp.buf.declaration()")
  (buf_key_map :n :gr "lua vim.lsp.buf.references({includeDeclaration = false})")
  (buf_key_map :n :gi "lua vim.lsp.buf.implementation()")
  (buf_key_map :n :K "lua vim.lsp.buf.hover()")
  (buf_key_map :n :<c-k> "lua vim.lsp.buf.signature_help()")
  (buf_key_map :n :<leader>lr "lua vim.lsp.buf.rename()")
  (buf_key_map :n :<leader>lf "lua vim.lsp.buf.formatting()")
  (buf_key_map :n :<leader>la "lua vim.lsp.buf.code_action()")
  (buf_key_map :v :<leader>la "lua vim.lsp.buf.range_code_action()")

  (when client.resolved_capabilities.code_lens
    (vim.cmd "
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
      augroup END")
    (buf_key_map :n :<space>ll "lua vim.lsp.codelens.run()"))

  (when client.resolved_capabilities.document_highlight
    (vim.api.nvim_command "autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()")
    (vim.api.nvim_command "autocmd CursorMoved,InsertEnter,WinLeave <buffer> lua vim.lsp.buf.clear_references()")))

(def- capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities)))

(defn- map [from to]
  (util.nnoremap from to))

(tset vim.lsp.handlers "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border :single}))
(tset vim.lsp.handlers "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border :single}))
(let [location_handler
      (fn [_ result ctx _]
        (when (or (= result nil) (vim.tbl_isempty result))
          (lua "return nil"))
        (if
          (vim.tbl_islist result)
          (do
            (lsp_util.jump_to_location (. result 1))
            (when (> (length result) 1)
              (lsp_util.set_qflist (lsp_util.locations_to_items result))
              (vim.api.nvim_command "botright copen")))
          (lsp_util.jump_to_location result)))]
  (tset vim.lsp.handlers "textDocument/definition" location_handler))


(let [lsp (require :lspconfig)
      servers [:hls :racket_langserver]]
  (when lsp
    (each [_ name (ipairs servers)]
      (let [{name config} lsp]
        (config.setup
          {:on_attach on_attach
           :capabilities capabilities
           :flags {:debounce_text_changes 100}})))
    (lsp.sumneko_lua.setup
      {:on_attach on_attach
       :capabilities capabilities
       :cmd ["/home/rhcher/workspace/lua-language-server/bin/Linux/lua-language-server"
             "/home/rhcher/workspace/lua-language-server/main.lua"]
       :settings {:Lua {:diagnostics {:enable true :globals [:vim :packer_plugins]}
                        :completion {:callSnippet :Replace}
                        :runtime {:version :LuaJIT}
                        :IntelliSense {:traceLocalSet true
                                       :traceReturn true
                                       :traceBeSetted true
                                       :traceFieldInject true}
                        :telemetry {:enable false}}}}
      :flags {:debounce_text_changes 100})
    (lsp.ccls.setup
      {:on_attach on_attach
       :capabilities capabilities
       :filetypes [:c :cpp]
       :cmd [:ccls]
       :root_dir (fn [fname]
                   (or ((utils.root_pattern :compile_command.json :.git :.ccls-root :.ccls) fname)
                       (utils.path.dirname fname)))
       :init_options {:capabilities {:foldingRangeProvider false
                                     :workspace {:wordspaceFolders {:support false}}}
                      :index {:onChange false
                              :initialNoLinkage true}
                      :cache {:directory "/tmp/ccls-cache/"}}
       :flags {:debounce_text_changes 100}})))
