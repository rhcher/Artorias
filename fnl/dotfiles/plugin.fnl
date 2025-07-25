(local {: autoload} (require :nfnl.module))

(local lazy (autoload :lazy))
(local a (autoload :nfnl.core))
(local util (autoload :dotfiles.util))

(import-macros {: map} :dotfiles.macros)

(local lazy-config
  {:defaults {:lazy true}
   :dev {:path "~/workspace/nvim_plugins/"}
   :performance {:rtp {:disabled_plugins [:netrwPlugin
                                          :tarPlugin
                                          :tutor
                                          :zipPlugin
                                          :tohtml
                                          :gzip
                                          :matchit
                                          :matchparen]}}})

(fn use [...]
  (let [pkgs [...]
        plugins []]
    (for [i 1 (a.count pkgs) 2]
      (let [name (. pkgs i)]
        (var opts (. pkgs (+ i 1)))
        (when (not= (a.get opts "mod" nil) nil)
          (set opts (collect [k v (pairs opts)]
                      (if (= k "mod")
                          (values "config" #(require (.. "dotfiles.plugin." v)))
                          (values k v)))))
        (if (or (not= (a.get opts "dir" nil) nil)
                (not= (a.get opts "url" nil) nil))
            (table.insert plugins opts)
            (table.insert plugins (a.assoc opts 1 name)))))
    (lazy.setup plugins lazy-config)))

(use
  "folke/lazy.nvim" {:event "VeryLazy"}
  "Olical/nfnl" {:lazy false
                 :branch "main"}
  "Olical/conjure" {:lazy false
                    :branch "main"
                    :mod "conjure"}
  "nvim-lua/plenary.nvim" {}
  "rhcher/srcery.nvim" {:lazy false
                        :priority 1000}
  "wtfox/jellybeans.nvim" {:lazy false
                           :priority 1000
                           :opts {}}
  "rhcher/vim-paper" {:priority 1000
                      :lazy false}
  "nvim-lualine/lualine.nvim" {:lazy false
                               :config true}
                               ; :dependencies "nvim-tree/nvim-web-devicons"}
  "junegunn/fzf" {:event "VeryLazy" :build "./install --bin"}
  "gbprod/substitute.nvim" {:config true
                            :keys [["<leader>x" "<cmd>lua require('substitute.exchange').operator()<cr>"]
                                   ["<leader>xx" "<cmd>lua require('substitute.exchange').line()<cr>"]
                                   {1 "X" 2 "<cmd>lua require('substitute.exchange').visual()<cr>" :mode "x"}
                                   ["<leader>xc" "<cmd>lua require('substitute.exchange').cancel()<cr>"]]}
  "nvim-treesitter/nvim-treesitter" {:branch "master"
                                     :build ":TSUpdate"
                                     :mod "treesitter"}
  "eraserhd/parinfer-rust" {:ft util.lisp-language
                            :config (fn [plugin]
                                      (vim.opt.rtp:append (.. plugin.dir "/target/release")))
                            :build "cargo build --release"}
  "harrygallagher4/nvim-parinfer-rust" {:ft util.lisp-language
                                        :config #(vim.api.nvim_create_autocmd "VimEnter"
                                                                              {:callback #((. (require "parinfer") :setup))})}
  "saghen/blink.cmp" {:version false
                      :event ["InsertEnter" "CmdlineEnter"]
                      :mod "completion"
                      :build "cargo build --release"}
  "hrsh7th/nvim-ix" {:dependencies ["hrsh7th/nvim-cmp-kit"]
                     :cond false
                     :lazy false
                     :mod "completion"}
  "dcampos/nvim-snippy" {:config
                         #(let [snippy (require :snippy)]
                            (map [:i :s] :<C-l> #(if (snippy.can_jump 1)
                                                     "<Plug>(snippy-next)"
                                                     "<ESC>A") {:expr true})
                            (map [:i :s] :<C-h> #(if (snippy.can_jump -1)
                                                  "<Plug>(snippy-previous)"
                                                  "<ESC>I") {:expr true}))}
  "mfussenegger/nvim-dap" {:lazy false
                           :mod "dap"
                           :dependencies ["rcarriga/nvim-dap-ui"
                                          "theHamsta/nvim-dap-virtual-text"]}
  "rcarriga/nvim-dap-ui" {:keys [{1 "<leader>du" 2 #((. (require "dapui") "toggle") {})}
                                 {1 "<leader>de" 2 #((. (require "dapui") "eval")) :mode [:n :v]}]
                          :dependencies ["mfussenegger/nvim-dap"
                                         "nvim-neotest/nvim-nio"]
                          :mod "dap"}
  "theHamsta/nvim-dap-virtual-text" {:lazy false
                                     :opts {}}
  "nvimdev/lspsaga.nvim" {:dependencies ["nvim-tree/nvim-web-devicons"
                                         "nvim-treesitter/nvim-treesitter"]
                          :event "LspAttach"
                          :mod "lspsaga"}
  "AndrewRadev/sideways.vim" {:event "VeryLazy"
                              :cond false
                              :init #(do
                                       (map [:x :o] :aa "<Plug>SidewaysArgumentTextobjA")
                                       (map [:x :o] :ia "<Plug>SidewaysArgumentTextobjI"))}
  "altermo/ultimate-autopair.nvim" {:branch "v0.6"
                                    :lazy false
                                    :dependencies ["nvim-treesitter/nvim-treesitter"]
                                    :mod "auto-pairs"}
  "utilyre/sentiment.nvim" {:version false
                            :event "VeryLazy"
                            :opts {}}
  "tpope/vim-fugitive" {:cmd "Git"}
  "junegunn/gv.vim" {:cmd "GV"
                     :dependencies ["tpope/vim-fugitive"]}
  "julienvincent/nvim-paredit" {:ft util.lisp-language
                                :mod "nvim-paredit"}
  "svban/YankAssassin.vim" {:event "VeryLazy"}
  "kana/vim-textobj-user" {:event "VeryLazy"
                           :dependencies ["glts/vim-textobj-comment"]}
  "chrisgrieser/nvim-various-textobjs" {:keys [{1 "iv" 2 "<cmd>lua require('various-textobjs').subword('inner')<CR>" :mode [:o :x]}
                                               {1 "av" 2 "<cmd>lua require('various-textobjs').subword('outer')<CR>" :mode [:o :x]}]}
  "AndrewRadev/linediff.vim" {:cmd "Linediff"}
  "tyru/open-browser.vim" {:keys [{1 "gx" 2 "<Plug>(openbrowser-smart-search)"
                                   :mode [:n :v]}]}
  "kevinhwang91/nvim-fundo" {:dependencies ["kevinhwang91/promise-async"]
                             :event "VeryLazy"
                             :build #((. (require "fundo") :install))
                             :config true}
  "kevinhwang91/nvim-ufo" {:dependencies ["kevinhwang91/promise-async"
                                          {1 :luukvbaal/statuscol.nvim
                                           :config #(let [builtin (require "statuscol.builtin")
                                                          statuscol (require "statuscol")]
                                                      (statuscol.setup {:relculright true
                                                                        :segments [{:text ["%s"] :click "v:lua.ScSa"}
                                                                                   {:text [builtin.lnumfunc " "] :click "v:lua.ScLa"}
                                                                                   {:text [builtin.foldfunc] :click "v:lua.ScFa"}]}))}]
                           :event "VeryLazy"
                           :config
                           #(let [ufo (require "ufo")]
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
                                                               (. ftmap filetype))}))}
  "kevinhwang91/nvim-bqf" {:ft "qf"
                           :init #(require "dotfiles.qftf")
                           :mod "bqf"}
  "RRethy/vim-illuminate" {:event ["BufReadPost" "BufNewFile"]
                           :config
                           #(let [illuminate (require "illuminate")]
                              (illuminate.configure
                                {:providers [:lsp :regex]
                                 :modes_denylist [:i]
                                 :large_file_cutoff 5000}))}
  "mbbill/undotree" {:cmd "UndotreeShow"}
  "NvChad/nvim-colorizer.lua" {:cmd "ColorizerToggle"
                               :main "colorizer"
                               :config true}
  "tpope/vim-repeat" {:event "VeryLazy"}
  "kylechui/nvim-surround" {:event "VeryLazy"
                            :config #(let [surround (require "nvim-surround")
                                           config (require "nvim-surround.config")]
                                       (surround.setup {:move_cursor false
                                                        :surrounds {"(" {:add ["(" ")"]
                                                                         :find #(config.get_selection {:motion "a("})
                                                                         :delete "^(.)().-(.)()$"}
                                                                    ")" {:add ["( " " )"]
                                                                         :find #(config.get_selection {:motion "a)"})
                                                                         :delete "^(. ?)().-( ?.)()$"}}}))}
  "mhinz/vim-grepper" {:keys ["gs"] :mod "grepper"}
  "lewis6991/gitsigns.nvim" {:event ["BufReadPre" "BufNewFile"]
                             :mod "gitsigns"}
  "folke/flash.nvim" {:event "VeryLazy"
                      :opts {:modes {:char {:enabled false}}}
                      :keys [{1 "s" :mode [:n :x :o] 2 #((. (require "flash") :jump))}
                             {1 "S" :mode [:n :x :o] 2 #((. (require "flash") :treesitter))}
                             {1 "r" :mode :o 2 #((. (require "flash") :remote))}
                             {1 "R" :mode [:x :o] 2 #((. (require "flash") :treesitter_search))}
                             {1 "<C-s>" :mode :c 2 #((. (require "flash") :toggle))}]}
  "booperlv/nvim-gomove" {:event "VeryLazy" :mod "move"}
  "zegervdv/nrpattern.nvim" {:keys ["<C-a>" "<C-x>"]
                             :config #((. (require "nrpattern") :setup))}
  "ThePrimeagen/harpoon" {:keys ["<leader>uu" "<leader>ua" "<leader>un"
                                 "<leader>up" "<leader>tc"]
                          :dependencies ["nvim-lua/plenary.nvim"]
                          :mod "harpoon"}
  "danymat/neogen" {:cmd "Neogen"
                    :opts {:snippet_engine "snippy"}}
  "kazhala/close-buffers.nvim" {:keys ["<leader>bk" "<leader>bo"]
                                :config
                                #(let [close-buffers (require "close_buffers")]
                                   (map :n :<leader>bk #(close-buffers.delete {:type :this}))
                                   (map :n :<leader>bo #(close-buffers.delete {:type :hidden})))}
  "anuvyklack/hydra.nvim" {:event "VeryLazy"
                           :dependencies ["anuvyklack/keymap-layer.nvim"
                                          "mrjones2014/smart-splits.nvim"]
                           :mod "hydra"}
  "cshuaimin/ssr.nvim" {:keys ["<leader>sr"]
                        :config
                        #(map [:n :x] "<leader>sr" (. (require "ssr") :open))}
  "dhruvasagar/vim-table-mode" {:cmd "TableModeToggle"
                                :init #(set vim.g.table_mode_corner "|")}
  "kevinhwang91/nvim-hlslens" {:event "VeryLazy"
                               :mod "hlslens"
                               :dependencies ["haya14busa/vim-asterisk"]}
  "mg979/vim-visual-multi" {:event "VeryLazy"}
  "max397574/better-escape.nvim" {:event "VeryLazy"
                                  :config #((. (require "better_escape") :setup) {:default_mappings false
                                                                                  :mappings {:i {:j {:k "<Esc>"}}}})}
  "sindrets/diffview.nvim" {:cmd "DiffviewOpen"}
  "chrisgrieser/nvim-spider" {:keys [{1 "w" 2 "<cmd>lua require('spider').motion('w')<CR>" :mode [:n :o :x]}
                                     {1 "e" 2 "<cmd>lua require('spider').motion('e')<CR>" :mode [:n :o :x]}
                                     {1 "b" 2 "<cmd>lua require('spider').motion('b')<CR>" :mode [:n :o :x]}
                                     {1 "ge" 2 "<cmd>lua require('spider').motion('ge')<CR>" :mode [:n :o :x]}]}
  "tiagovla/scope.nvim" {:lazy false
                         :config true}
  "nvim-dd.git" {:url "https://gitlab.com/yorickpeterse/nvim-dd.git"
                 :event "VeryLazy"
                 :opts {:timeout 200}}
  "willothy/flatten.nvim" {:lazy false
                           :config true
                           :priority 1001}
  "Julian/lean.nvim" {:event ["BufReadPre *.lean" "BufNewFile *.lean"]
                      :dependencies ["nvim-lua/plenary.nvim"]
                      :opts {:lsp {}
                             :mappings true}}
  "OXY2DEV/markview.nvim" {:lazy false
                           :priority 49}
  "folke/snacks.nvim" {:priority 1000
                       :lazy false
                       :mod "snacks"}
  "echasnovski/mini.nvim" {:version false
                           :keys [["<leader>e" "<cmd>lua MiniFiles.open()<CR>"]]
                           :mod "mini"}
  "tani/dmacro.vim" {:lazy false
                     :keys [{1 "<C-y>" 2 "<Plug>(dmacro-play-macro)" :mode [:i :n]}]}
  "nvzone/typr" {:dependencies "nvzone/volt"
                 :opts {}
                 :cmd ["Typr" "TyprStats"]}
  "MagicDuck/grug-far.nvim" {:lazy false})
