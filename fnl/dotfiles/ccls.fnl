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
                  (when (or (= result nil) (vim.tbl_isempty result))
                    (vim.notify (.. "No " n " found"))
                    (lua "return"))
                  (let [client (vim.lsp.get_client_by_id ctx.client_id)]
                    (if
                      (vim.tbl_islist result)
                      (do
                        (util.jump_to_location (. result 1)
                                               client.offset_encoding)
                        (vim.cmd "norm zz"))
                      (util.jump_to_location result
                                             client.offset_encoding))))
        params ((fn []
                  (let [param (util.make_position_params)]
                    (tset param :direction n)
                    param)))]
    (vim.lsp.buf_request 0 "$ccls/navigate" params handler)))

(defn call [title]
  (let [handler (handler title)
        params ((fn []
                  (let [param (util.make_position_params)]
                    (tset param :callee (match title
                                          "caller" false
                                          "callee" true))
                    param)))]
    (print title)
    (vim.lsp.buf_request 0 "$ccls/call" params handler)))

(defn ccls_var [title]
  (let [handler (handler title)
        params ((fn []
                  (let [param (util.make_position_params)]
                    (tset param :kind (match title
                                        "field" 1
                                        "local" 2
                                        "fieldOrLocal" 3
                                        "parameter" 4))
                    param)))]
    (print title)
    (vim.lsp.buf_request 0 "$ccls/vars" params handler)))

(defn member [title]
  (let [handler (handler (.. "class " title))
        params ((fn []
                  (let [param (util.make_position_params)]
                    (tset param :kind (match title
                                        "variables" 4
                                        "functions" 3
                                        "types" 2))
                    param)))]
    (print (.. "Class " title))
    (vim.lsp.buf_request 0 "$ccls/member" params handler)))

(defn inheritance [title]
  (let [handler (handler title)
        params ((fn []
                  (let [param (util.make_position_params)]
                    (tset param :derived (match title
                                           "base" false
                                           "derived" true))
                    param)))]
    (print title)
    (vim.lsp.buf_request 0 "$ccls/inheritance" params handler)))

(defn extend_ref [role]
  (let [handler (handler (.. "Ref " role))
        params ((fn []
                  (let [param (util.make_position_params)]
                    (tset param :role (match role
                                        "read" 8
                                        "write" 16
                                        "macro" 64))
                    (tset param :excludeRole 32)
                    param)))]
    (print (.. "Ref " role))
    (vim.lsp.buf_request 0 "textDocument/references" params handler)))
