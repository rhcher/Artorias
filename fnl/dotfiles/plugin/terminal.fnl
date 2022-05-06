(module dotfiles.plugin.terminal
  {autoload {term toggleterm}})

(term.setup {:size (fn [t]
                     (if 
                       (= t.direction "horizontal")
                       15
                       (= t.direction "vertical")
                       (* vim.o.columns 0.4)))
             :open_mapping "<M-=>"
             :hide_numbers true
             :shade_terminals true
             :start_in_insert true
             :insert_mappings true
             :persist_size true
             :direction "vertical"
             :close_on_exit true
             :shell vim.o.shell})

(vim.keymap.set :n :<space>ot "<cmd>ToggleTerm direction=horizontal<CR>" {:silent true})
(vim.keymap.set :n :<space>oT "<cmd>ToggleTerm direction=vertical<CR>" {:silent true})
