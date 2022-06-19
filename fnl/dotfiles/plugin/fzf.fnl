(module dotfiles.plugin.fzf
  {autoload {fzf "fzf-lua"}})

(fzf.setup {:winopts {:split "belowright new"
                      :border "single"}})
