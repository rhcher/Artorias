(local deck (require :deck))
((. (require :deck.easy) :setup))
(vim.api.nvim_create_autocmd
  :User
  {:callback (fn [e]
               (local ctx e.data.ctx)
               ; (ctx.keymap :n :<Esc> #(ctx.set_preview_mode false))
               (ctx.keymap :n :<CR>
                           (deck.action_mapping :choose_action))
               (ctx.keymap :n :<C-l>
                           (deck.action_mapping :refresh))
               (ctx.keymap :n :i
                           (deck.action_mapping :prompt))
               (ctx.keymap :n :a
                           (deck.action_mapping :prompt))
               (ctx.keymap :n "<Tab>"
                           (deck.action_mapping :toggle_select))
               (ctx.keymap :n "*"
                           (deck.action_mapping :toggle_select_all))
               (ctx.keymap :n :p
                           (deck.action_mapping :toggle_preview_mode))
               (ctx.keymap :n :d
                           (deck.action_mapping :delete))
               ; (ctx.keymap :n :<CR>
               ;             (deck.action_mapping :default))
               (ctx.keymap :n :o
                           (deck.action_mapping :open))
               (ctx.keymap :n :O
                           (deck.action_mapping :open_keep))
               (ctx.keymap :n :s
                           (deck.action_mapping :open_split))
               (ctx.keymap :n :v
                           (deck.action_mapping :open_vsplit))
               (ctx.keymap :n :N
                           (deck.action_mapping :create))
               (ctx.keymap :n :w
                           (deck.action_mapping :write))
               (ctx.keymap :n :<C-u>
                           (deck.action_mapping :scroll_preview_up))
               (ctx.keymap :n :<C-d>
                           (deck.action_mapping :scroll_preview_down))
               (ctx.keymap :c :<C-y>
                           (fn []
                             (vim.api.nvim_feedkeys (vim.keycode :<Esc>)
                                                    :n
                                                    true)
                             (vim.schedule #(ctx.do_action :default))))
               (ctx.keymap :c :<C-n> #(ctx.set_cursor (+ (ctx.get_cursor) 1)))
               (ctx.keymap :c :<C-p> #(ctx.set_cursor (- (ctx.get_cursor) 1)))
               (ctx.keymap :n :q ctx.hide)
               (ctx.keymap :n :<Esc> ctx.hide)
               (ctx.keymap :n :<C-c> ctx.hide)
               (ctx.keymap :c :<C-c> #((vim.api.nvim_feedkeys (vim.keycode "<Esc>") :n :true)
                                       (vim.schedule ctx.hide))))
               ; (ctx.prompt))
   :pattern :DeckStart})
(vim.keymap.set :n :<Leader>ff "<Cmd>Deck files<CR>"
                {:desc "Show recent files, buffers, and more"})
(vim.keymap.set :n :<Leader>gr "<Cmd>Deck grep<CR>" {:desc "Start grep search"})
(vim.keymap.set :n :<Leader>gi "<Cmd>Deck git<CR>" {:desc "Open git launcher"})
(vim.keymap.set :n :<Leader>he "<Cmd>Deck helpgrep<CR>"
                {:desc "Live grep all help tags"})
(vim.keymap.set :n "<Leader>;"
                (fn []
                  (let [ctx (. (deck.get_history) 1)]
                    (when ctx (ctx.show)))))
(vim.keymap.set :n :<Leader>n
                (fn []
                  (let [ctx (. (deck.get_history) 1)]
                    (when ctx
                      (ctx.set_cursor (+ (ctx.get_cursor) 1))
                      (ctx.do_action :default)))))

(vim.api.nvim_create_autocmd
  :User
  {:callback (fn []
               (set vim.wo.cursorline true)
               (set vim.o.signcolumn "yes:1")
               (set vim.o.statuscolumn "%=%s")
               (when (= vim.o.cmdheight 0)
                 (set vim.o.cmdheight 1)
                 (vim.api.nvim_create_autocmd
                   :User
                   {:callback (fn []
                                (set vim.o.cmdheight
                                     0))
                    :once true
                    :pattern :DeckHide})))
   :pattern :DeckShow})
