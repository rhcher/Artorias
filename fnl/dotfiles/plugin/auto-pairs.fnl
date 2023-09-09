(local {: autoload} (require :nfnl.module))
(local util (autoload :dotfiles.util))

(let [pair (require "ultimate-autopair")]
  (pair.setup {:cr {:conf {:nft util.lisp-language}}
               :bs {:map ["<bs>" "<C-w>"]}
               :tabout {:enable true
                        :map "<tab>"
                        :hopout true
                        :do_nothing_if_fail false}}))
