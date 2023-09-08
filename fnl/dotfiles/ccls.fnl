(local {: autoload} (require "nfnl.module"))
(local util (autoload "vim.lsp.util"))

(fn handler [title]
  (fn [_ result ctx _]
    (let [client (vim.lsp.get_client_by_id ctx.client_id)]
      (if (or (= result nil) (vim.tbl_isempty result))
          (vim.notify (.. "No " title " found"))
          (do
            (vim.fn.setqflist {} " " {:title title
                                      :items (util.locations_to_items result
                                                                      client.offset_encoding)})
            (vim.api.nvim_command "botright copen"))))))

(fn navigate [n]
  (let [handler (fn [_ result ctx _]
                  (if (or (= result nil) (vim.tbl_isempty result))
                    (vim.notify (.. "No " n " found"))
                    (let [client (vim.lsp.get_client_by_id ctx.client_id)]
                      (if
                        (vim.tbl_islist result)
                        (do
                          (util.jump_to_location (. result 1)
                                                 client.offset_encoding)
                          (vim.cmd "norm zz"))
                        (util.jump_to_location result
                                               client.offset_encoding)))))
        params (let [param (util.make_position_params)]
                 (tset param :direction n)
                 param)]
    (vim.lsp.buf_request 0 "$ccls/navigate" params handler)))

(fn ccls_info []
  (let [handler (fn [_ result _ _] (vim.print result))]
    (vim.lsp.buf_request 0 "$ccls/info" nil handler)))

(fn ccls_fileInfo []
  (let [handler (fn [err result _ _]
                  (vim.print err)
                  (vim.print result))
        params (let [param (util.make_text_document_params 0)]
                 (tset param "dependencies" true)
                 (tset param "includes" true)
                 (tset param "skipped_ranges" true)
                 param)]
    (vim.print params)
    (vim.lsp.buf_request 0 "$ccls/fileInfo" params handler)))

(fn call [title]
  (let [handler (handler title)
        params (let [param (util.make_position_params)]
                 (tset param :callee (match title
                                       "caller" false
                                       "callee" true))
                 param)]
    (print title)
    (vim.lsp.buf_request 0 "$ccls/call" params handler)))

(fn ccls_var [title]
  (let [handler (handler title)
        params (let [param (util.make_position_params)]
                 (tset param :kind (match title
                                     "field" 1
                                     "local" 2
                                     "fieldOrLocal" 3
                                     "parameter" 4))
                 param)]
    (print title)
    (vim.lsp.buf_request 0 "$ccls/vars" params handler)))

(fn member [title]
  (let [handler (handler (.. "class " title))
        params (let [param (util.make_position_params)]
                 (tset param :kind (match title
                                     "variables" 4
                                     "functions" 3
                                     "types" 2))
                 param)]
    (print (.. "Class " title))
    (vim.lsp.buf_request 0 "$ccls/member" params handler)))

(fn inheritance [title]
  (let [handler (handler title)
        params (let [param (util.make_position_params)]
                 (tset param :derived (match title
                                        "base" false
                                        "derived" true))
                 param)]
    (print title)
    (vim.lsp.buf_request 0 "$ccls/inheritance" params handler)))

(fn extend_ref [role]
  (let [handler (handler (.. "Ref " role))
        params (let [param (util.make_position_params)]
                 (tset param :role (match role
                                     "read" 8
                                     "write" 16
                                     "macro" 64))
                 (tset param :excludeRole 32)
                 param)]
    (print (.. "Ref " role))
    (vim.lsp.buf_request 0 "textDocument/references" params handler)))

(local semantic-hightlight-handler
  (fn [err result ctx config]
    (let [client (vim.lsp.get_clients {:id ctx.client_id})
          {: symbols : uri} result
          bufnr (vim.uri_to_bufnr uri)
          ns (vim.api.nvim_create_namespace "ccls-semantic-hightlights")
          highlighter (fn [symbol hl_group]
                        (each [_ lsRange (ipairs symbol.lsRanges)]
                          (vim.api.nvim_buf_set_extmark bufnr
                                                        ns
                                                        lsRange.start.line
                                                        lsRange.start.character
                                                        {:end_row lsRange.end.line
                                                         :end_col lsRange.end.character
                                                         :hl_group hl_group
                                                         :strict false
                                                         :priority 125})))]
      (when client
        (vim.api.nvim_buf_clear_namespace bufnr ns 0 -1)
        (each [_ symbol (ipairs symbols)]
          (match symbol
            (where symbol (= symbol.kind 3)) ; Namespace
            (highlighter symbol "LspCxxHlGroupNamespace")
            (where symbol (= symbol.kind 12)) ; Function
            (highlighter symbol "LspCxxHlSymFunction")
            (where symbol (= symbol.kind 6)) ; Method
            (highlighter symbol "LspCxxHlSymMethod")
            (where symbol (= symbol.kind 254)) ; StaticMethod
            (highlighter symbol "LspCxxHlSymStaticMethod")
            (where symbol (= symbol.kind 9)) ; Constructor
            (highlighter symbol "LspCxxHlSymConstructor")
            (where symbol (= symbol.kind 13)) ; Variable
            (highlighter symbol "LspCxxHlSymVariable")
            (where symbol (= symbol.kind 253)) ; Parameter
            (highlighter symbol "LspCxxHlSymParameter")
            (where symbol (= symbol.kind 5)) ; class
            (highlighter symbol "LspCxxHlSymClass")
            (where symbol (= symbol.kind 23)) ; struct
            (highlighter symbol "LspCxxHlSymStruct")
            (where symbol (= symbol.kind 10)) ; Enum
            (highlighter symbol "LspCxxHlSymEnum")
            (where symbol (= symbol.kind 252)) ; TypeAlias
            (highlighter symbol "LspCxxHlSymTypeAlias")
            (where symbol (= symbol.kind 26)) ; TypeParameter
            (highlighter symbol "LspCxxHlSymTypeParameter")
            (where symbol (= symbol.kind 8)) ; Field
            (highlighter symbol "LspCxxHlSymField")
            (where symbol (= symbol.kind 22)) ; Enummember
            (highlighter symbol "LspCxxHlSymEnumMember")
            (where symbol (= symbol.kind 255)) ; Macro
            (highlighter symbol "LspCxxHlSymMacro")))))))

(local skipped-ranges-handler
  (fn [err result ctx config]
    (let [client (vim.lsp.get_clients {:id ctx.client_id})
          ns (vim.api.nvim_create_namespace "lsp-skipped-ranges-handler")]
      (when (and client result)
        (match result
          (where {: skippedRanges : uri} (= (length skippedRanges) 0))
          (vim.api.nvim_buf_clear_namespace (vim.uri_to_bufnr uri)
                                            ns
                                            0
                                            -1)
          {: skippedRanges : uri}
          (each [_ lsRange (ipairs skippedRanges)]
            (vim.api.nvim_buf_set_extmark (vim.uri_to_bufnr uri)
                                          ns
                                          lsRange.start.line
                                          lsRange.start.character
                                          {:end_row lsRange.end.line
                                           :end_col lsRange.end.character
                                           :hl_group "Comment"
                                           :priority 126})))))))

{: navigate
 : ccls_info
 : ccls_fileInfo
 : call
 : ccls_var
 : member
 : inheritance
 : extend_ref
 : semantic-hightlight-handler
 : skipped-ranges-handler}
