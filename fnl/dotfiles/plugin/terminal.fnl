(import-macros {: map} :dotfiles.macros)

(let [(_ term) (pcall require "toggleterm")]
  (term.setup {:size (fn [t]
                       (if (= t.direction "horizontal")
                           15
                           (= t.direction "vertical")
                           (* vim.o.columns 0.4)))
               :open_mapping "<M-=>"
               :hide_numbers true
               :shade_terminals false
               :start_in_insert true
               :insert_mappings true
               :persist_size true
               :direction "vertical"
               :close_on_exit true
               :shell vim.o.shell}))

(map :n :<leader>ot "<cmd>ToggleTerm direction=horizontal<CR>")
(map :n :<leader>oT "<cmd>ToggleTerm direction=vertical<CR>")
