(import-macros {: tx} :config.macros)

(vim.api.nvim_create_autocmd :FileType {:pattern ["fennel" "markdown" "harpoon"] :callback #(set vim.b.snacks_indent false)})

[(tx "echasnovski/mini.nvim" {:version false
                              :lazy false
                              :keys [["<space>e" "<cmd>lua MiniFiles.open()<CR>"]]
                              :config #(let [mini_file (require "mini.files")
                                             mini_icons (require "mini.icons")]
                                         (mini_file.setup)
                                         (mini_icons.setup {:extension {:fnl {:glyph ""}}
                                                            :filetype {:fennel {:glyph ""}}}))})
 (tx "folke/snacks.nvim" {:lazy false
                          :priority 1000
                          :opts {:indent {:animate {:style "down"}}
                                 :picker {:layout {:preset "ivy"
                                                   :cycle false}}
                                 :terminal {}
                                 :styles {}
                                 :images {}
                                 :quickfile {}
                                 :notifier {}}
                          :keys [(tx :<leader>fs #(Snacks.picker.grep))
                                 (tx :<leader>ff #(Snacks.picker.files))
                                 (tx :<leader>fc (fn [] (Snacks.picker.files {:cwd (vim.fn.stdpath "config")})))
                                 (tx :<leader>fb #(Snacks.picker.buffers))
                                 (tx :<leader>bb #(Snacks.picker.buffers))
                                 (tx :<leader>fh #(Snacks.picker.help))
                                 (tx :<leader>fk #(Snacks.picker.keymaps))
                                 (tx :<leader>fl #(Snacks.picker.lines))
                                 (tx :<leader>fp #(Snacks.picker.projects))
                                 (tx :<leader>ss #(Snacks.picker.smart))
                                 (tx :<leader>su #(Snacks.picker.undo))
                                 (tx :<leader>sh #(Snacks.picker.highlights))
                                 (tx :<leader>nf #(Snacks.notifier.show_history))
                                 (tx :<leader>ot #(Snacks.terminal))]})]
