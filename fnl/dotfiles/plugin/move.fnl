(module dotfiles.plugin.move
  {autoload {move gomove
             util dotfiles.util}})

(move.setup {:map_defaults false})

(vim.keymap.set :n "<A-n>" :<Plug>GoNSMLeft {:noremap true})
(vim.keymap.set :n "<A-m>" :<Plug>GoNSMDown {:noremap true})
(vim.keymap.set :n "<A-,>" :<Plug>GoNSMUp {:noremap true})
(vim.keymap.set :n "<A-.>" :<Plug>GoNSMRight {:noremap true})

(vim.keymap.set :x "<A-n>" :<Plug>GoVSMLeft {:noremap true})
(vim.keymap.set :x "<A-m>" :<Plug>GoVSMDown {:noremap true})
(vim.keymap.set :x "<A-,>" :<Plug>GoVSMUp {:noremap true})
(vim.keymap.set :x "<A-.>" :<Plug>GoVSMRight {:noremap true})

(vim.keymap.set :n "<A-N>" :<Plug>GoNSDLeft {:noremap true})
(vim.keymap.set :n "<A-M>" :<Plug>GoNSDDown {:noremap true})
(vim.keymap.set :n "<A-<>" :<Plug>GoNSDUp {:noremap true})
(vim.keymap.set :n "<A->>" :<Plug>GoNSDRight {:noremap true})

(vim.keymap.set :x "<A-N>" :<Plug>GoVSDLeft {:noremap true})
(vim.keymap.set :x "<A-M>" :<Plug>GoVSDDown {:noremap true})
(vim.keymap.set :x "<A-<>" :<Plug>GoVSDUp {:noremap true})
(vim.keymap.set :x "<A->>" :<Plug>GoVSDRight {:noremap true})
