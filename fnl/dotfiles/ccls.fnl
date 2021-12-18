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
