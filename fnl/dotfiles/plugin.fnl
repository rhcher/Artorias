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
                    :branch "develop"
                    :mod "conjure"}
  "nvim-lua/plenary.nvim" {}
  "nvim-tree/nvim-web-devicons" {:mod "devicons"}
  "rhcher/srcery.nvim" {:lazy false
                        :priority 1000
                        :config #(vim.cmd.colorscheme "srcery")}
  ; "metalelf0/jellybeans-nvim" {:lazy false
  ;                              :priority 1000}
  ; "rktjmp/lush.nvim" {:lazy false}
  ; "rhcher/vim-paper" {:priority 1000
  ;                     :config #(vim.cmd.colorscheme "paper")}
  ; "rebelot/kanagawa.nvim" {:priority 1000}
  "nvim-lualine/lualine.nvim" {:event "VeryLazy"
                               :config true
                               :dependencies "nvim-tree/nvim-web-devicons"}
  ; "nvimdev/whiskyline.nvim" {:event "VimEnter"
  ;                            :opts {:bg "#2a2a47"
  ;                                   :bg "#f2de91"}
  ;                            :dependencies ["nvim-tree/nvim-web-devicons"]}
  "junegunn/fzf" {:event "VeryLazy" :build "./install --bin"}
  "karb94/neoscroll.nvim" {:event "VeryLazy"
                           :cond false
                           :config true}
  "gbprod/substitute.nvim" {:config true
                            :keys [["<leader>x" "<cmd>lua require('substitute.exchange').operator()<cr>"]
                                   ["<leader>xx" "<cmd>lua require('substitute.exchange').line()<cr>"]
                                   {1 "X" 2 "<cmd>lua require('substitute.exchange').visual()<cr>" :mode "x"}
                                   ["<leader>xc" "<cmd>lua require('substitute.exchange').cancel()<cr>"]]}
  "rcarriga/nvim-notify" {:keys [{1 "<leader>un"
                                  2 #((. (require "notify") :dismiss) {:silent true :pending true})}]
                          :opts {:timeout 3000
                                 :background_colour "#000000"
                                 :max_height (fn [] (math.floor (* vim.o.lines 0.75)))
                                 :max_width (fn [] (math.floor (* vim.o.columns 0.75)))}}
  "folke/noice.nvim" {:event "VeryLazy"
                      :cond false
                      :dependencies ["MunifTanjim/nui.nvim"]
                      :keys [{1 "<S-Enter>"
                              2 #((. (require "noice") :redirect) (vim.fn.getcmdline))
                              :mode "c"}]
                      :opts {:lsp {:progress {:enabled false}
                                   :hover {:enabled false}
                                   :override {"vim.lsp.util.convert_input_to_markdown_lines" false
                                              "vim.lsp.util.stylize_markdown" false
                                              "cmp.entry.get_documentation" false}}
                             :presets {:bottom_search true
                                       :command_palette true
                                       :long_message_to_split true}
                             :messages {:enabled false}}}
  "nvim-treesitter/nvim-treesitter" {:version false
                                     :build ":TSUpdate"
                                     :mod "treesitter"}
  "eraserhd/parinfer-rust" {:ft util.lisp-language
                            :config (fn [plugin]
                                      (vim.opt.rtp:append (.. plugin.dir "/target/release")))
                            :build "cargo build --release"}
  "harrygallagher4/nvim-parinfer-rust" {:ft util.lisp-language
                                        :config #(vim.api.nvim_create_autocmd "VimEnter"
                                                                              {:callback #((. (require "parinfer") :setup))})}

  ; "saghen/blink.cmp" {:lazy false
  ;                     :version "v0.*"
  ;                     :opts {:highlight {:use_nvim_cmp_as_default true}}}
  "yioneko/nvim-cmp" {:version false
                      :branch "perf"
                      :event ["InsertEnter"]
                      :dependencies ["hrsh7th/cmp-nvim-lsp"
                                     "hrsh7th/cmp-buffer"
                                     "hrsh7th/cmp-path"
                                     "PaterJason/cmp-conjure"
                                     "hrsh7th/cmp-cmdline"
                                     "onsails/lspkind-nvim"
                                     "dcampos/nvim-snippy"]
                      :mod "completion"}
  "hrsh7th/cmp-cmdline" {:event "CmdlineEnter"}
  "onsails/lspkind-nvim" {:event "LspAttach"}
  "dcampos/nvim-snippy" {:config
                         #(let [snippy (require :snippy)]
                            (map [:i :s] :<C-l> #(if (snippy.can_jump 1)
                                                     "<Plug>(snippy-next)"
                                                     "<ESC>A") {:expr true})
                            (map [:i :s] :<C-h> #(if (snippy.can_jump -1)
                                                  "<Plug>(snippy-previous)"
                                                  "<ESC>I") {:expr true}))}
  "neovim/nvim-lspconfig" {
                           :dependencies ["hrsh7th/cmp-nvim-lsp"]
                           :lazy false
                           :mod "nvim-lspconfig"}
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
  "Wansmer/symbol-usage.nvim" {:event "LspAttach"
                               :cond false
                               :opts {:vt_position "end_of_line"}}
  "AndrewRadev/sideways.vim" {:event "VeryLazy"
                              :init #(do
                                       (map [:x :o] :aa "<Plug>SidewaysArgumentTextobjA")
                                       (map [:x :o] :ia "<Plug>SidewaysArgumentTextobjI"))}
  "altermo/ultimate-autopair.nvim" {:event ["InsertEnter" "CmdlineEnter"]
                                    :branch "v0.6"
                                    :dependencies ["nvim-treesitter/nvim-treesitter"]
                                    :mod "auto-pairs"}
  "stevearc/oil.nvim" {:event "VeryLazy"
                       :dependencies [:nvim-tree/nvim-web-devicons]
                       :opts {:columns ["icon" "permissions" "size" "mtime"]}}
  "utilyre/sentiment.nvim" {:version "*"
                            :event "VeryLazy"
                            :opts {}}
  "ibhagwan/fzf-lua" {:cmd "FzfLua"
                      :commit "eb63a4bbfd203942737f76d4cf5424f6fb016a9d"
                      :dependencies ["nvim-tree/nvim-web-devicons"]
                      :opts {:winopts {:split "bot new"
                                       :border "single"}
                             :copen "bot new"}
                      :init #(let [fzf (require "fzf-lua")]
                               (map :n :<leader>ff fzf.files)
                               (map :n :<leader>fp #(fzf.files {:cwd "~/.config/nvim"}))
                               (map :n :<leader>fs fzf.live_grep_native)
                               (map :n :<leader>fb fzf.buffers)
                               (map :n :<leader>bb fzf.buffers)
                               (map :n :<leader>fh fzf.help_tags)
                               (map :n :<leader>fk fzf.keymaps)
                               (map :n :<leader>fl fzf.blines)
                               (map :n :<leader>pl fzf.lines)
                               (map :n :<leader>fo fzf.oldfiles)
                               (map :n :<leader>fc fzf.commands)
                               (map :n :<leader>fq fzf.quickfix)
                               (map :n :<leader>fg fzf.git_bcommits))}
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
  "lukas-reineke/indent-blankline.nvim" {:event "VeryLazy"
                                         :mod "indent"}
  ; "numToStr/Comment.nvim" {:event "VeryLazy" :config true}
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
  "akinsho/nvim-toggleterm.lua" {:keys ["<leader>ot" "<leader>oT"]
                                 :mod "terminal"}
  "folke/flash.nvim" {:event "VeryLazy"
                      :opts {}
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
  "nvimdev/dashboard-nvim" {:event "VimEnter"
                            :cond false
                            :mod "dashboard"
                            :dependencies ["nvim-tree/nvim-web-devicons"]}
  "gbprod/cutlass.nvim" {:event "VeryLazy"
                         :opts {}}
  "kevinhwang91/nvim-hlslens" {:event "VeryLazy"
                               :mod "hlslens"
                               :dependencies ["haya14busa/vim-asterisk"]}
  "mg979/vim-visual-multi" {:event "VeryLazy"}
  "max397574/better-escape.nvim" {:event "VeryLazy"
                                  :config #((. (require "better_escape") :setup) {:mapping ["jk"]})}
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
                      :dependencies ["neovim/nvim-lspconfig"
                                     "nvim-lua/plenary.nvim"]
                      :opts {:lsp {}
                             :mappings true}}
  "MeanderingProgrammer/markdown.nvim" {:main "render-markdown"
                                        :lazy false
                                        :opts {}
                                        :name "render-markdown"
                                        :dependencies ["nvim-treesitter/nvim-treesitter"]})
