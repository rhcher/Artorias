(module dotfiles.plugin.close_buffers
  {autoload {buffers close_buffers}})

(let [map vim.keymap.set
      opt {:noremap true :silent true}]
  (map :n :<leader>bk (fn [] (buffers.delete {:type :this})) opt)
  (map :n :<leader>bo (fn [] (buffers.delete {:type :hidden})) opt))
