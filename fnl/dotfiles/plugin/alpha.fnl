(module dotfiles.plugin.alpha)

(let [alpha (require :alpha)
      dashboard (require :alpha.themes.dashboard)]
  (alpha.setup dashboard.config))
