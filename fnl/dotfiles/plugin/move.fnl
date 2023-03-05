(module dotfiles.plugin.move
  {import-macros [[{: map} :dotfiles.macros]]})

(when-let [(_ move) (pcall require "gomove")]
  (move.setup {:map_defaults false}))

(map :n "<A-n>" :<Plug>GoNSMLeft)
(map :n "<A-m>" :<Plug>GoNSMDown)
(map :n "<A-,>" :<Plug>GoNSMUp)
(map :n "<A-.>" :<Plug>GoNSMRight)

(map :x "<A-n>" :<Plug>GoVSMLeft)
(map :x "<A-m>" :<Plug>GoVSMDown)
(map :x "<A-,>" :<Plug>GoVSMUp)
(map :x "<A-.>" :<Plug>GoVSMRight)

(map :n "<A-N>" :<Plug>GoNSDLeft)
(map :n "<A-M>" :<Plug>GoNSDDown)
(map :n "<A-<>" :<Plug>GoNSDUp)
(map :n "<A->>" :<Plug>GoNSDRight)

(map :x "<A-N>" :<Plug>GoVSDLeft)
(map :x "<A-M>" :<Plug>GoVSDDown)
(map :x "<A-<>" :<Plug>GoVSDUp)
(map :x "<A->>" :<Plug>GoVSDRight)
