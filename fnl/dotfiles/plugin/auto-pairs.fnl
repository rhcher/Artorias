(module dotfiles.plugin.auto-pairs
  {autoload {util dotfiles.util}})

(let [pair (require "ultimate-autopair")]
  (pair.setup {:cr {:conf {:nft util.lisp-language}}
               :bs {:conf {:nft util.lisp-language}}}))
