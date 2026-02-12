(import-macros {: tx : map} :config.macros)
(local {: autoload} (require :nfnl.module))
(local g (autoload :config.global))

[(tx "max397574/better-escape.nvim"
     {:event "VeryLazy"
      :config #((. (require "better_escape") :setup) {:default_mappings false
                                                      :mappings {:i {:j {:k "<Esc>"}}}})})

 (tx "eraserhd/parinfer-rust" 
     {:ft g.lisp-language
      :config (fn [plugin]
                (vim.opt.rtp:append (.. plugin.dir "/target/release")))
      :build "cargo build --release"})

 (tx "harrygallagher4/nvim-parinfer-rust" 
     {:ft g.lisp-language
      :config #(vim.api.nvim_create_autocmd "VimEnter"
                                            {:callback #((. (require "parinfer") :setup))})})
 (tx "Olical/conjure" {:lazy false
                       :branch "main"
                       :init (fn [] (set vim.g.conjure#filetype#rust false)
                                    (set vim.g.conjure#mapping#doc_word ["gk"]))})
 (tx "saghen/blink.cmp" {:version false
                         :event ["InsertEnter" "CmdlineEnter"]
                         :build "cargo build --release"
                         :config #(let [(_ blink) (pcall require "blink.cmp")
                                        (_ snippy) (pcall require "snippy")]
                                    (blink.setup {:keymap {:preset "super-tab"
                                                           :<C-k> false
                                                           :<Tab> ["select_and_accept" "snippet_forward" "fallback"]}
                                                  :snippets {:expand (fn [snippet] (snippy.expand_snippet snippet))
                                                             :active (fn [filter] (if (= filter nil)
                                                                                      nil
                                                                                      (~= filter nil)
                                                                                      (snippy.can_jump (. filter :direction))))
                                                             :jump (fn [direction] (if (= direction 1)
                                                                                       (snippy.next)
                                                                                       (= direction -1)
                                                                                       (snippy.previous)))}
                                                  :cmdline {:keymap {:preset "inherit"}
                                                            :completion {:menu {:auto_show true}}}
                                                  :appearance {:use_nvim_cmp_as_default true
                                                               :nerd_font_variant "mono"}
                                                  :completion {:trigger {:prefetch_on_insert true}
                                                               :list {:selection {:preselect false}}
                                                               :accept {:dot_repeat false}}
                                                  :sources {:default ["lsp" "path" "buffer"]}
                                                  :signature {:enabled true}}))})
 (tx "dcampos/nvim-snippy" {:config #(let [snippy (require :snippy)]
                                       (map [:i :s] :<C-l> #(if (snippy.can_jump 1)
                                                                "<Plug>(snippy-next)"
                                                                "<ESC>A") {:expr true})
                                       (map [:i :s] :<C-h> #(if (snippy.can_jump -1)
                                                             "<Plug>(snippy-previous)"
                                                             "<ESC>I") {:expr true}))})

 (tx "altermo/ultimate-autopair.nvim" {:branch "v0.6"
                                       :lazy false
                                       :dependencies ["nvim-treesitter/nvim-treesitter"]
                                       :config #(let [pair (require "ultimate-autopair")]
                                                  (pair.setup {:cr {:conf {:nft g.lisp-language}}
                                                               :bs {; :map ["<C-w>" "<del"]
                                                                    :space false
                                                                    :single_delete false}
                                                               :space {:enable true}
                                                               :tabout {:enable true
                                                                        :map "<tab>"
                                                                        :hopout true
                                                                        :do_nothing_if_fail false}}))})
 (tx "svban/YankAssassin.vim" {:event "VeryLazy"})
 (tx "kana/vim-textobj-user" {:event "VeryLazy"
                              :dependencies ["glts/vim-textobj-comment"]})
 (tx "julienvincent/nvim-paredit"
     {:ft g.lisp-language
      :config #(let [paredit (require "nvim-paredit")]
                 (paredit.setup
                    {:keys {:<localleader>w [#(paredit.cursor.place_cursor
                                                (paredit.wrap.wrap_element_under_cursor "( " ")")
                                                {:placement "inner_start"
                                                 :mode "insert"})
                                             "Wrap element insert head"]
                            :<localleader>W [#(paredit.cursor.place_cursor
                                                (paredit.wrap.wrap_element_under_cursor "(" " )")
                                                {:placement "inner_end"
                                                 :mode "insert"})
                                             "Wrap element insert tail"]
                            :<localleader>i [#(paredit.cursor.place_cursor
                                                (paredit.wrap.wrap_enclosing_form_under_cursor "( " ")")
                                                {:placement "inner_start"
                                                 :mode "insert"})
                                             "Wrap form insert head"]
                            :<localleader>I [#(paredit.cursor.place_cursor
                                                (paredit.wrap.wrap_enclosing_form_under_cursor "(" " )")
                                                {:placement "inner_end"
                                                 :mode "insert"})
                                             "Wrap form insert tail"]}}))})
 (tx "svban/YankAssassin.vim" {:event "VeryLazy"})
 (tx "kana/vim-textobj-user" {:event "VeryLazy"
                              :dependencies ["glts/vim-textobj-comment"]})
 (tx "chrisgrieser/nvim-various-textobjs" {:keys [{1 "iv" 2 "<cmd>lua require('various-textobjs').subword('inner')<CR>" :mode [:o :x]}
                                                  {1 "av" 2 "<cmd>lua require('various-textobjs').subword('outer')<CR>" :mode [:o :x]}]})

 (tx "kylechui/nvim-surround"
     {:event "VeryLazy"
      :config #(let [surround (require "nvim-surround")
                     config (require "nvim-surround.config")]
                 (surround.setup {:move_cursor false
                                  :surrounds {"(" {:add ["(" ")"]
                                                   :find #(config.get_selection {:motion "a("})
                                                   :delete "^(.)().-(.)()$"}
                                              ")" {:add ["( " " )"]
                                                   :find #(config.get_selection {:motion "a)"})
                                                   :delete "^(. ?)().-( ?.)()$"}}}))})
 (tx "tani/dmacro.vim" {:lazy false
                        :keys [{1 "<C-y>" 2 "<Plug>(dmacro-play-macro)" :mode [:i :n]}]})]
