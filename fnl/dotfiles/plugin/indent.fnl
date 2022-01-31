(module dotfiles.plugin.indent)

(let [indent (require "indent-o-matic")]
  (indent.setup {}))

; (set vim.g.sleuth_automatic 1)
