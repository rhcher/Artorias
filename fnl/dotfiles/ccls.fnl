(module dotfiles.ccls
  {autoload {util vim.lsp.util}})

(defn- handler [title]
  (fn [_ result _ _]
    (when (or (= result nil) (vim.tbl_isempty result))
      (lua "return"))
    (when (vim.tbl_islist result)
      (vim.fn.setqflist {} " " {:title title
                                :items (util.locations_to_items result)})
      (vim.api.nvim_command "botright copen"))))

(defn navigate [n]
  (let [handler (fn [_ result _ _]
                  (when (or (= result nil) (vim.tbl_isempty result))
                    (lua "return"))
                  (if
                    (vim.tbl_islist result)
                    (do
                      (util.jump_to_location (. result 1))
                      (vim.cmd "norm! zz"))
                    (util.jump_to_location result)))
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
