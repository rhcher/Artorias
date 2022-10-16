(module dotfiles.init
  {require [dotfiles.core
            dotfiles.mapping
            dotfiles.plugins_conf
            dotfiles.plugin
            dotfiles.lspconfig
            dotfiles.diagnostic]
   autoload {c aniseed.compile}})

(c.glob :*.fnl
        :/home/rhcher/.config/nvim/fnl/dotfiles/ftplugin/
        :/home/rhcher/.config/nvim/after/ftplugin/)
