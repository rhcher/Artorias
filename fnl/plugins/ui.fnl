(import-macros {: tx : map : augroup} :config.macros)

(var config nil)
(var lens-bak nil)
(fn override-lens [render pos-list nearest idx rel-idx]
  (let [_ rel-idx
        (lnum col) (unpack (. pos-list idx))]
    (var (text chunks) nil)
    (if nearest
        (do
          (set text (: "[%d/%d]" :format idx (length pos-list)))
          (set chunks [[" " :Ignore] [text :VM_Extend]]))
        (do
          (set text (: "[%d]" :format idx))
          (set chunks [[" " :Ignore] [text :HlSearchLens]])))
    (render.setVirt 0 (- lnum 1) (- col 1) chunks nearest)))

(fn start []
  (let [hlslens (require "hlslens")]
    (when hlslens (set config (require :hlslens.config))
      (set lens-bak config.override_lens)
      (set config.override_lens override-lens)
      (hlslens.start))))

(fn exit []
  (let [hlslens (require "hlslens")]
    (when hlslens (set config.override_lens lens-bak) (hlslens.start))))

(augroup "VMlens"
         [[:User] {:pattern "visual_multi_start"
                   :callback #(start)}]
         [[:User] {:pattern "visual_multi_exit"
                   :callback #(exit)}])

[(tx "nvim-lualine/lualine.nvim" {:lazy false
                                  :config true})
 (tx "rhcher/srcery.nvim" {:lazy false
                           :priority 1000
                           :config #(vim.cmd.colorscheme "srcery")})
 (tx "rhcher/vim-paper" {:lazy false
                         :priority 1000
                         :cond false
                         :config #(vim.cmd.colorscheme "paper")})
 (tx "kevinhwang91/nvim-ufo" {:dependencies [(tx "kevinhwang91/promise-async")
                                             (tx "luukvbaal/statuscol.nvim"
                                                 {:config #(let [builtin (require "statuscol.builtin")
                                                                 statuscol (require "statuscol")]
                                                             (statuscol.setup {:relculright true
                                                                               :segments [{:text ["%s"] :click "v:lua.ScSa"}
                                                                                          {:text [builtin.lnumfunc " "] :click "v:lua.ScLa"}
                                                                                          {:text [builtin.foldfunc] :click "v:lua.ScFa"}]}))})]
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
 (tx "kevinhwang91/nvim-hlslens" {:event "VeryLazy"
                                  :dependencies ["haya14busa/vim-asterisk"]
                                  :config #(let [start-str "<Cmd>lua require('hlslens').start()<CR>"
                                                 hlslens (require "hlslens")]
                                             (hlslens.setup)
                                             (map :n :n (.. "<Cmd>execute('normal! ' . v:count1 . 'n')<CR>" start-str))
                                             (map :n :N (.. "<Cmd>execute('normal! ' . v:count1 . 'N')<CR>" start-str))
                                             (map [:n :x] :* (.. "<Plug>(asterisk-z*)" start-str))
                                             (map [:n :x] :# (.. "<Plug>(asterisk-z#)" start-str))
                                             (map [:n :x] :g* (.. "<Plug>(asterisk-gz*)" start-str))
                                             (map [:n :x] :g# (.. "<Plug>(asterisk-gz*)" start-str)))})
 (tx "utilyre/sentiment.nvim" {:version false
                               :event "VeryLazy"
                               :opts {}})]
