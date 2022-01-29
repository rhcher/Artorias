(module dotfiles.plugin.litee
  {autoload {litee-lib litee.lib
             litee-symboltree litee.symboltree
             litee-calltree litee.calltree}})

(litee-lib.setup {:tree {:icon_set "nerd"}})
(litee-calltree.setup {:on_open "panel"})
(litee-symboltree.setup {:on_open "panel"})
