(module dotfiles.plugin.harpoon)

(let [ui (require :harpoon.ui)
      mark (require :harpoon.mark)
      term (require :harpoon.term)
      cmd (require :harpoon.cmd-ui)]
  (vim.keymap.set :n :<leader>uu
                  ui.toggle_quick_menu
                  {:noremap true :silent true})
  (vim.keymap.set :n :<leader>ua
                  mark.add_file
                  {:noremap true :silent true})
  (vim.keymap.set :n :<leader>un
                  ui.nav_next
                  {:noremap true :silent true})
  (vim.keymap.set :n :<leader>up
                  ui.nav_prev
                  {:noremap true :silent true})
  (vim.keymap.set :n :<leader>tc
                  cmd.toggle_quick_menu
                  {:noremap true :silent true}))
