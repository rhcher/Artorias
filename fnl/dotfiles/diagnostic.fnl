(module dotfiles.diagnostic
  {autoload {nvim aniseed.nvim}})

(vim.diagnostic.config {:virtual_text false
                        :signs true
                        :update_in_insert false
                        :float {:header ""
                                :prefix ""
                                :source :if_many
                                :focusable false
                                :border :single}})

(let [signs {:Error " " :Warn " " :Hint " " :Info " "}]
  (each [type icon (pairs signs)]
    (let [hl (.. "DiagnosticSign" type)]
      (vim.fn.sign_define hl {:text icon :texthl hl :numhl hl}))))

(nvim.set_keymap :n 
                 :<space>le 
                 "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line', close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' }})<CR>"
                 {:noremap true :silent true})

(nvim.set_keymap :n 
                 :<space>lq 
                 "<cmd>lua vim.diagnostic.setqflist()<CR>"
                 {:noremap true :silent true})

(nvim.set_keymap :n 
                 "[e"
                 "<cmd>lua vim.diagnostic.goto_prev()<CR>"
                 {:noremap true :silent true})

(nvim.set_keymap :n 
                 "]e"
                 "<cmd>lua vim.diagnostic.goto_next()<CR>"
                 {:noremap true :silent true})
