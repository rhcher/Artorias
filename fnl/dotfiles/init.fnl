(module dotfiles.init
  {require [dotfiles.core
            dotfiles.mapping
            dotfiles.plugin
            dotfiles.indentation
            dotfiles.diagnostic]
   autoload {c aniseed.compile}})

(c.glob :*.fnl
        :/home/rhcher/.config/nvim/after/ftplugin/
        :/home/rhcher/.config/nvim/after/ftplugin/)
