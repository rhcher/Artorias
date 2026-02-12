;; Define a sign for code actions
(vim.fn.sign_define :CodeAction {:text "💡"
                                 :texthl :Question})

;; Function to update signs for visible lines
; (fn update_signs []
;   (let [bufnr (vim.api.nvim_get_current_buf)
;         clients (vim.lsp.get_clients {:bufnr bufnr :method "textDocument/codeAction"})]
;     (when (not (next clients))
;       ; (vim.notify "No client support textDocument/code_action")
;       (lua "return"))
;     ;; Clear existing signs in this group to avoid duplicates
;     ; (vim.fn.sign_unplace :CodeActionGroup {:buffer bufnr})
;     (vim.lsp.buf_request_all
;       bufnr
;       "textDocument/codeAction"
;       (fn [client]
;         (let [win (vim.api.nvim_get_current_win)
;               start_line (vim.fn.line "w0")
;               end_line (vim.fn.line "w$")]
;           (local params (vim.lsp.util.make_range_params win client.offset_encoding))
;           (vim.print params)
;           (local context {})
;           (set context.triggerKind vim.lsp.protocol.CodeActionTriggerKind.Invoked)
;           (local ns-push (vim.lsp.diagnostic.get_namespace client.id false))
;           (local ns-pull (vim.lsp.diagnostic.get_namespace client.id true))
;           (local diagnostics {})
;           (local lnum (- (. (vim.api.nvim_win_get_cursor 0) 1) 1))
;           (vim.list_extend diagnostics
;                            (vim.diagnostic.get bufnr {: lnum :namespace ns-pull}))
;           (vim.list_extend diagnostics
;                            (vim.diagnostic.get bufnr {: lnum :namespace ns-push}))
;           (set params.context
;                (vim.tbl_extend :force context
;                                {:diagnostics (vim.tbl_map (fn [d] d.user_data.lsp)
;                                                           diagnostics)}))
;           params))
;       (fn [result]
;         (vim.print result)))))

    ; (let [start_line (vim.fn.line "w0")
    ;       end_line (vim.fn.line "w$")]
    ;   ;; Iterate over visible lines
    ;   (for [line start_line end_line]
    ;     (vim.print "code_action request")
    ;     (let [params {:range {:start {:line (- line 1) :character 0}
    ;                           :end {:line (- line 1) :character 8192}}}]
    ;       ;; Asynchronously check for code actions on each line
    ;       (vim.lsp.buf.code_action
    ;         params
    ;         (fn [actions]
    ;           (when (and actions (not (vim.tbl_isempty actions)))
    ;             ;; If actions are available, place a sign
    ;             (vim.fn.sign_place line :CodeActionGroup :CodeAction bufnr {:lnum line})))))))))

(fn update_signs []
  (let [bufnr (vim.api.nvim_get_current_buf)
        clients (vim.lsp.get_clients {:bufnr bufnr :method "textDocument/codeAction"})]
    (when (not (next clients))
      (lua "return"))
    ; (vim.fn.sign_unplace :CodeActionGroup {:buffer bufnr})
    (vim.lsp.buf_request_all
      bufnr
      "textDocument/codeAction"
      (fn [client]
        (var params (vim.lsp.util.make_range_params (vim.api.nvim_get_current_win) client.offset_encoding))
        (var context {})
        (set context.triggerKind vim.lsp.protocol.CodeActionTriggerKind.Invoked)
        (var ns-push (vim.lsp.diagnostic.get_namespace client.id false))
        (var ns-pull (vim.lsp.diagnostic.get_namespace client.id true))
        (var diagnostics {})
        ; (var lnum (- (. (vim.api.nvim_win_get_cursor 0) 1) 1))
        (vim.list_extend diagnostics
                         (vim.diagnostic.get bufnr {:namespace ns-pull}))
        (vim.list_extend diagnostics
                         (vim.diagnostic.get bufnr {:namespace ns-push}))
        (set params.context
             (vim.tbl_extend :force context
                             {:diagnostics (vim.tbl_map (fn [d] d.user_data.lsp)
                                                        diagnostics)}))
        params)
      (fn [result]
        (let [[{: context : result}] result]
          (when (not (next result))
            (lua "return"))
          (let [[{: command : kind : title}] result]
            (when (not (next command))
              (lua "return"))
            (let [{: arguments : command : title} command
                  [{: selection}] arguments
                  {: start : end} selection
                  line (+ start.line 1)]
              (vim.fn.sign_place line :CodeActionGroup :CodeAction bufnr {:lnum line}))))))))
                           ; (vim.print start.line))))))))}))

; Trigger the update function when the user stops moving the cursor
; or when a buffer is entered in a window.
(vim.api.nvim_create_autocmd [:DiagnosticChanged]
                             {:group (vim.api.nvim_create_augroup :CodeActionSign {:clear false})
                              :callback update_signs})

; Clear signs when leaving the buffer
; (vim.api.nvim_create_autocmd :BufLeave
;                              {:group group
;                               :callback (fn [] (vim.fn.sign_unplace :CodeActionGroup))})
