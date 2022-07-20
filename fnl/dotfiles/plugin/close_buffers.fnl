(module dotfiles.plugin.close_buffers
  {autoload {buffers close_buffers}
   require-macros [dotfiles.macros]})

(map :n :<leader>bk (fn [] (buffers.delete {:type :this})))
(map :n :<leader>bo (fn [] (buffers.delete {:type :hidden})))
