(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             nvim aniseed.nvim
             cmplsp cmp_nvim_lsp
             lsp_util vim.lsp.util
             utils lspconfig.util}})

(defn- on_attach [client bufnr]

  (defn- buf_key_map [mode from to]
    (vim.keymap.set mode from to {:buffer true :noremap true :silent true}))

  (defn- buf_set_option [...]
    (vim.api.nvim_buf_set_option bufnr ...))


  (when client.resolved_capabilities.completion
    (buf_set_option :omnifunc "v:lua.vim.lsp.omnifunc"))

  (buf_key_map :n :gd vim.lsp.buf.definition)
  (buf_key_map :n :gD vim.lsp.buf.declaration)
  (buf_key_map :n :gi vim.lsp.buf.implementation)
  (buf_key_map :n :gr (fn [] (vim.lsp.buf.references {:includeDeclaration false})))
  (buf_key_map :n :K vim.lsp.buf.hover)
  (buf_key_map :n :<leader>lr vim.lsp.buf.rename)
  (buf_key_map :n :<leader>lf vim.lsp.buf.formatting)
  (buf_key_map :n :<leader>la vim.lsp.buf.code_action)
  (buf_key_map :v :<leader>la vim.lsp.buf.range_code_action)

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

  (when client.resolved_capabilities.code_lens
    (vim.cmd "
             augroup lsp_document_highlight
             autocmd! * <buffer>
             autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
             augroup END")
    (buf_key_map :n :<space>ll vim.lsp.codelens.run))

  (when client.resolved_capabilities.document_highlight
    (vim.api.nvim_command "autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()")
    (vim.api.nvim_command "autocmd CursorMoved,InsertEnter,WinLeave <buffer> lua vim.lsp.buf.clear_references()")))

(let [location_handler
      (fn [_ result ctx _]
        (when (or (= result nil) (vim.tbl_isempty result))
          (lua "return nil"))
        (let [client (vim.lsp.get_client_by_id ctx.client_id)]
          (if
            (vim.tbl_islist result)
            (do
              (lsp_util.jump_to_location (. result 1) client.offset_encoding)
              (when (> (length result) 1)
                (vim.fn.setqflist {} " " {:title "LSP Location"
                                          :items (lsp_util.locations_to_items result
                                                                              client.offset_encoding)})
                (vim.api.nvim_command "botright copen")))
            (lsp_util.jump_to_location result client.offset_encoding))))]
  (tset vim.lsp.handlers "textDocument/definition" location_handler)
  (tset vim.lsp.handlers "textDocument/hover" (vim.lsp.with vim.lsp.handlers.hover {:border :single}))
  (tset vim.lsp.handlers "textDocument/signatureHelp" (vim.lsp.with vim.lsp.handlers.signature_help {:border :single})))

(let [lsp (require :lspconfig)
      capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))
      servers [:hls :ocamllsp]]
  (when lsp
    (each [_ name (ipairs servers)]
      (let [{name config} lsp]
        (config.setup
          {:on_attach on_attach
           :capabilities capabilities
           :flags {:debounce_text_changes 200}})))
    (lsp.sumneko_lua.setup
      {:on_attach on_attach
       :capabilities capabilities
       :cmd ["/home/rhcher/workspace/lua-language-server/bin/Linux/lua-language-server"]
       :settings {:Lua {:diagnostics {:enable true :globals [:vim :packer_plugins]}
                        :completion {:callSnippet :Replace}
                        :runtime {:version :LuaJIT}
                        :IntelliSense {:traceLocalSet true
                                       :traceReturn true
                                       :traceBeSetted true
                                       :traceFieldInject true}
                        :telemetry {:enable false}}}}
      :flags {:debounce_text_changes 200})
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
       :flags {:debounce_text_changes 200}})
    (lsp.racket_langserver.setup
      {:on_attach on_attach
       :capabilities capabilities
       :filetypes [:racket]})
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
       :flags {:debounce_text_changes 200}})))
