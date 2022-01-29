(module dotfiles.plugin.close_buffers
  {autoload {cbuffers close_buffers}})

(cbuffers.setup)

(vim.keymap.set :n :<space>bo (fn [] (cbuffers.delete {:type "hidden"}) {:noremap true :silent true}))
(vim.keymap.set :n :<space>bk (fn [] (cbuffers.delete {:type "this"})) {:noremap true :silent true})
