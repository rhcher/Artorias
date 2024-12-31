(local deck (require :deck))
((. (require :deck.easy) :setup))
(vim.api.nvim_create_autocmd :User
                             {:callback (fn [e] (local ctx e.data.ctx)
                                          (ctx.keymap :n :<Tab>
                                                      (deck.make_mapping_function :choose_action))
                                          (ctx.keymap :n :<C-l>
                                                      (deck.make_mapping_function :refresh))
                                          (ctx.keymap :n :i
                                                      (deck.make_mapping_function :prompt))
                                          (ctx.keymap :n "@"
                                                      (deck.make_mapping_function :toggle_select))
                                          (ctx.keymap :n "*"
                                                      (deck.make_mapping_function :toggle_select_all))
                                          (ctx.keymap :n :p
                                                      (deck.make_mapping_function :toggle_preview_mode))
                                          (ctx.keymap :n :d
                                                      (deck.make_mapping_function :delete))
                                          (ctx.keymap :n :<CR>
                                                      (deck.make_mapping_function :default))
                                          (ctx.keymap :n :o
                                                      (deck.make_mapping_function :open))
                                          (ctx.keymap :n :O
                                                      (deck.make_mapping_function :open_keep))
                                          (ctx.keymap :n :s
                                                      (deck.make_mapping_function :open_s))
                                          (ctx.keymap :n :v
                                                      (deck.make_mapping_function :open_v))
                                          (ctx.keymap :n :N
                                                      (deck.make_mapping_function :create))
                                          (ctx.keymap :n :<C-u>
                                                      (deck.make_mapping_function :scroll_preview_up))
                                          (ctx.keymap :n :<C-d>
                                                      (deck.make_mapping_function :scroll_preview_down)))
                              :pattern :DeckStart})
(vim.keymap.set :n :<Leader>ff "<Cmd>Deck files<CR>"
                {:desc "Show recent files, buffers, and more"})
(vim.keymap.set :n :<Leader>gr "<Cmd>Deck grep<CR>" {:desc "Start grep search"})
(vim.keymap.set :n :<Leader>gi "<Cmd>Deck git<CR>" {:desc "Open git launcher"})
(vim.keymap.set :n :<Leader>he "<Cmd>Deck helpgrep<CR>"
                {:desc "Live grep all help tags"})
(vim.keymap.set :n "<Leader>;"
                (fn []
                  (let [ctx (. ((. (require :deck) :get_history)) 1)]
                    (when ctx (ctx.show)))))
