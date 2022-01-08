(module dotfiles.plugin.close_buffers
  {autoload {cbuffers close_buffers}})

(cbuffers.setup)

(vim.api.nvim_set_keymap :n
                         :<space>bo
                         "<cmd>lua require('close_buffers').delete({type = 'hidden'})<CR>"
                         {:noremap true
                          :silent true})

(vim.api.nvim_set_keymap :n
                         :<space>bk
                         "<cmd>lua require('close_buffers').delete({type = 'this'})<CR>"
                         {:noremap true
                          :silent true})
