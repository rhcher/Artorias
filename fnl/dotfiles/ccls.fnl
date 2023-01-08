(module dotfiles.ccls
  {autoload {util vim.lsp.util}})

(defn- handler [title]
  (fn [_ result ctx _]
    (let [client (vim.lsp.get_client_by_id ctx.client_id)]
      (if (or (= result nil) (vim.tbl_isempty result))
          (vim.notify (.. "No " title " found"))
          (do
            (vim.fn.setqflist {} " " {:title title
                                      :items (util.locations_to_items result
                                                                      client.offset_encoding)})
            (vim.api.nvim_command "botright copen"))))))

(defn navigate [n]
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

(defn call [title]
  (let [handler (handler title)
        params (let [param (util.make_position_params)]
                 (tset param :callee (match title
                                       "caller" false
                                       "callee" true))
                 param)]
    (print title)
    (vim.lsp.buf_request 0 "$ccls/call" params handler)))

(defn ccls_var [title]
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

(defn member [title]
  (let [handler (handler (.. "class " title))
        params (let [param (util.make_position_params)]
                 (tset param :kind (match title
                                     "variables" 4
                                     "functions" 3
                                     "types" 2))
                 param)]
    (print (.. "Class " title))
    (vim.lsp.buf_request 0 "$ccls/member" params handler)))

(defn inheritance [title]
  (let [handler (handler title)
        params (let [param (util.make_position_params)]
                 (tset param :derived (match title
                                        "base" false
                                        "derived" true))
                 param)]
    (print title)
    (vim.lsp.buf_request 0 "$ccls/inheritance" params handler)))

(defn extend_ref [role]
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

(def semantic-hightlight-handler
  (fn [err result ctx config]
    (let [client (vim.lsp.get_client_by_id ctx.client_id)]
      (when client
        (let [{: symbols : uri} result]
          (each [_ symbol (ipairs symbols)]
            (let [{: id : kind : lsRanges : parentKind : ranges : storage} symbol]
              (each [_ lsRange (ipairs lsRanges)]
                (let [{: end : start} lsRange
                      {:character character_end :line line_end} end
                      {:character character_start :line line_start} start]
                  (print "end: {" character_end line_end "}\n")
                  (print "start: {" character_start line_start "}")))))
          (print "hell"))
        (print "hello")
        (print "hello")))))

(def skipped-ranges-handler
  (fn [err result ctx config]
    (let [client (vim.lsp.get_client_by_id ctx.client_id)
          ns (vim.api.nvim_create_namespace "lsp-skipped-ranges-handler")]
      (when (and client result)
        (match result
          (where {: skippedRanges : uri} (= (length skippedRanges) 0))
          (vim.api.nvim_buf_clear_namespace (vim.api.nvim_get_current_buf)
                                            ns
                                            0
                                            -1)
          {: skippedRanges : uri}
          (each [_ lsRange (ipairs skippedRanges)]
            (vim.api.nvim_buf_set_extmark (vim.api.nvim_get_current_buf)
                                          ns
                                          lsRange.start.line
                                          lsRange.start.character
                                          {:end_row lsRange.end.line
                                           :end_col lsRange.end.character
                                           :hl_group "Comment"
                                           :priority 150})))))))
