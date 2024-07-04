(import-macros {: map} :dotfiles.macros)

(let [ui (require "harpoon.ui")
      mark (require "harpoon.mark")]
  (map :n :<leader>uu #(ui.toggle_quick_menu))
  (map :n :<leader>ua #(mark.add_file)))
