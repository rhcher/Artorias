(local {: autoload} (require :nfnl.module))
(local util (autoload :dotfiles.util))

(let [pair (require "ultimate-autopair")]
  (pair.setup {:cr {:conf {:nft util.lisp-language}}
               :bs {:map ["<bs>" "<C-w>"]}}))
