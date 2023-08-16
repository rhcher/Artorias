(import-macros {: map} :dotfiles.macros)

(let [ui (require :harpoon.ui)
      mark (require :harpoon.mark)
      term (require :harpoon.term)
      cmd (require :harpoon.cmd-ui)]
  (map :n :<leader>uu ui.toggle_quick_menu)
  (map :n :<leader>ua mark.add_file)
  (map :n :<leader>un ui.nav_next)
  (map :n :<leader>up ui.nav_prev)
  (map :n :<leader>tc cmd.toggle_quick_menu))
