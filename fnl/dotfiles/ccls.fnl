(module dotfiles.ccls
  {autoload {util vim.lsp.util}})

(defn navigate [n]
  (let [handler (fn [_ result _ _]
                  (when (or (= result nil) (vim.tbl_isempty result))
                    (lua "return"))
                  (if
                    (vim.tbl_islist result)
                    (util.jump_to_location (. result 1))
                    (util.jump_to_location result)))
        direction (fn []
                    (let [param (util.make_position_params)]
                      (tset param :direction n)
                      param))]
    (vim.lsp.buf_request 0 "$ccls/navigate" (direction) handler)))

(defn call [n]
  (let [handler (fn [_ result _ _]
                  (when (or (= result nil) (vim.tbl_isempty result))
                    (lua "return"))
                  (when (and (vim.tbl_islist result) (> (length result) 1))
                    (let [title (if (= n true) "Caller" "Callee")]
                      (print title)
                      (vim.fn.setqflist {} " " {:title title
                                                :items (util.locations_to_items result)}))
                    (vim.api.nvim_command "botright copen")))
        call (fn []
               (let [param (util.make_position_params)]
                 (tset param :callee n)
                 param))]
    (vim.lsp.buf_request 0 "$ccls/call" (call) handler)))

(defn ccls_var [title]
  (let [n (match title
            "field" 1
            "local" 2
            "parameter" 4)
        handler (fn [_ result _ _]
                  (when (or (= result nil) (vim.tbl_isempty result))
                    (lua "return"))
                  (when (vim.tbl_islist result)
                    (vim.fn.setqflist {} " " {:title title
                                              :items (util.locations_to_items result)})
                    (vim.api.nvim_command "botright copen")))
        kind (fn []
               (let [param (util.make_position_params)]
                 (tset param :kind n)
                 param))]
    (print title)
    (vim.lsp.buf_request 0 "$ccls/vars" (kind) handler)))
