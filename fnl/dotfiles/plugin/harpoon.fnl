(import-macros {: map} :dotfiles.macros)

(let [harpoon (require "harpoon")]
  (harpoon:setup)
  (map :n :<leader>ua #(: (harpoon:list) :add))
  (map :n :<leader>uu #(harpoon.ui:toggle_quick_menu (harpoon:list))))
