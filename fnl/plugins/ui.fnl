(import-macros {: tx : map} :config.macros)

[(tx "nvim-lualine/lualine.nvim" {:lazy false
                                  :config true})
 (tx "rhcher/srcery.nvim" {:lazy false
                           :priority 1000
                           :config #(vim.cmd.colorscheme "srcery")})
 (tx "rhcher/vim-paper" {:lazy false
                         :priority 1000
                         :cond false
                         :config #(vim.cmd.colorscheme "paper")})
 (tx "kevinhwang91/nvim-ufo" {:dependencies [(tx "kevinhwang91/promise-async"
                                                 (tx "luukvbaal/statuscol.nvim"
                                                     {:config #(let [builtin (require "statuscol.builtin")
                                                                     statuscol (require "statuscol")]
                                                                 (statuscol.setup {:relculright true
                                                                                   :segments [{:text ["%s"] :click "v:lua.ScSa"}
                                                                                              {:text [builtin.lnumfunc " "] :click "v:lua.ScLa"}
                                                                                              {:text [builtin.foldfunc] :click "v:lua.ScFa"}]}))}))]
                              :event "VeryLazy"
                              :config #(let [ufo (require "ufo")]
                                         (map :n :zR ufo.openAllFolds)
                                         (map :n :zM ufo.closeAllFolds)
                                         (local ftmap
                                           {:vim "indent"
                                            :fennel "treesitter"
                                            :python "indent"
                                            :git ""
                                            :sagaoutline ""
                                            :sagafinder ""})
                                         (ufo.setup {:provider_selector (fn [bufnr filetype buftype]
                                                                          (. ftmap filetype))}))})
 (tx "kevinhwang91/nvim-bqf" {:ft "qf"
                              :init #(require :config.qftf)
                              :opts {:preview {:auto_preview false
                                               :border [" " "━" " " " " " " "━" " " " "]
                                               :winblend 0}
                                     :auto_resize_height true}})
 (tx "utilyre/sentiment.nvim" {:version false
                               :event "VeryLazy"
                               :opts {}})]
