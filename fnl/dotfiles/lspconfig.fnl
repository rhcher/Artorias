(local {: autoload} (require "nfnl.module"))
(local protocol (autoload "vim.lsp.protocol"))
(import-macros {: autocmd : augroup : map} "dotfiles.macros")

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
                   :callback #(vim.lsp.codelens.refresh {:bufnr bufnr})})
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

       ; (map [:i :s] :<C-l> #(if (vim.snippet.jumpable 1)
       ;                          (vim.snippet.jump 1)
       ;                          (vim.api.nvim_input "<Esc>A")))
       ;
       ; (map [:i :s] :<C-h> #(if (vim.snippet.jumpable -1)
       ;                          (vim.snippet.jump -1)
       ;                          (vim.api.nvim_input "<Esc>I")))

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
