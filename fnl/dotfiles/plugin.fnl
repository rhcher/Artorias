(module dotfiles.plugin
  {autoload {a aniseed.core
             util dotfiles.util
             : lazy}
   require-macros [dotfiles.macros]})

(defn- safe-require-plugin-config [name]
  (let [(ok? err) (pcall require (.. "dotfiles.plugin" name))]
    (when (not ok?)
      (print (.. "dotfiles error " err)))))

(defn use [...]
  (let [pkgs [...]
        plugins []]
    (for [i 1 (a.count pkgs) 2]
      (let [name (. pkgs i)
            opts (. pkgs (+ i 1))]
        ;; TODO: use :mod avoid require dotfiles.plugin.sometion
        (-?> (. opts :mod) (safe-require-plugin-config))
        (table.insert plugins (a.assoc opts 1 name))))
    ;; TODO: workaround
    (table.insert plugins {:dir "/home/rhcher/workspace/vim-lsp-cxx-highlight/"
                           :ft [:c :cpp]})
    (lazy.setup plugins)))

(use
  "folke/lazy.nvim" {}
  "Olical/aniseed" {:event "VeryLazy":branch "develop"}
  "Olical/conjure" {:event "VeryLazy" :branch "develop"}
  "feline-nvim/feline.nvim" {:event "VeryLazy" :config true}
  "junegunn/fzf" {:event "VeryLazy" :build "./install --bin"}
  "gbprod/substitute.nvim" {:config true
                            :keys [["sx" "<cmd>lua require('substitute.exchange').operator()<cr>"]
                                   ["sxx" "<cmd>lua require('substitute.exchange').line()<cr>"]
                                   {1 "X" 2 "<cmd>lua require('substitute.exchange').visual()<cr>" :mode "x"}
                                   ["sxc" "<cmd>lua require('substitute.exchange').cancel()<cr>"]]}
  "rcarriga/nvim-notify" {:keys [{1 "<leader>un"
                                  2 #((. (require "notify") :dismiss) {:silent true :pending true})}]
                          :opts {:timeout 3000
                                 :background_colour "#000000"
                                 :max_height (fn [] (math.floor (* vim.o.lines 0.75)))
                                 :max_width (fn [] (math.floor (* vim.o.columns 0.75)))}}
  "folke/noice.nvim" {:event "VeryLazy"
                      :dependencies ["MunifTanjim/nui.nvim"]
                      :keys [{1 "<S-Enter>"
                              2 #((. (require "noice") :redirect) (vim.fn.getcmdline))
                              :mode "c"}]
                      :opts {:lsp {:override {"vim.lsp.util.convert_input_to_markdown_lines" true
                                              "vim.lsp.util.stylize_markdown" true
                                              "cmp.entry.get_documentation" true}
                                   :presets {:bottom_search true
                                             :command_palette true
                                             :long_message_to_split true
                                             :lsp_doc_border true}}}}
  "nvim-treesitter/nvim-treesitter" {:event "BufReadPost"
                                     :version false
                                     :build ":TSUpdate"
                                     :config #(require "dotfiles.plugin.treesitter")}
  "rhcher/srcery.nvim" {:config #(vim.cmd.colorscheme "srcery")
                        :priority 1000}
  "rhcher/vim-paper" {:lazy true}
  "rebelot/kanagawa.nvim" {:lazy true}
                           ;; :config (fn [] (vim.cmd.colorscheme "kanagawa"))
                           ;; :priority 1000}
  "eraserhd/parinfer-rust" {:ft util.lisp-language
                            :build "cargo build --release"}
  "hrsh7th/nvim-cmp" {:version false
                      :event "VeryLazy"
                      :dependencies [:hrsh7th/cmp-nvim-lsp
                                     :hrsh7th/cmp-buffer
                                     :hrsh7th/cmp-path
                                     :PaterJason/cmp-conjure
                                     :hrsh7th/cmp-cmdline
                                     :onsails/lspkind-nvim]
                      :config #(require "dotfiles.plugin.cmp")}
  "echasnovski/mini.ai" {:event "VeryLazy"
                         :dependencies [{1 "nvim-treesitter/nvim-treesitter-textobjects"
                                         :init #(let [loader (require "lazy.core.loader")]
                                                  (loader.disable_rtp_plugin "nvim-treesitter-textobjects"))}]
                         :opts #(let [ai (require "mini.ai")]
                                  {:n_lines 500
                                   :search_method "cover"
                                   :custom_textobjects {:o (ai.gen_spec.treesitter
                                                             {:a ["@block.outer" "@conditional.outer" "@loop.outer"]
                                                              :i ["@block.inner" "@conditional.inner" "@loop.inner"]} {})
                                                        :f (ai.gen_spec.treesitter {:a "@function.outer" :i "@function.inner"} {})}})
                         :config (fn [_ opts]
                                   (let [ai (require "mini.ai")]
                                     (ai.setup opts)))}
  "dcampos/nvim-snippy" {:event "VeryLazy"
                         :init
                         #(let [snippy (require :snippy)]
                              (vim.keymap.set [:i :s] :<C-l> #(if (snippy.can_jump 1)
                                                                  "<Plug>(snippy-next)"
                                                                  "<ESC>A") {:expr true})
                              (vim.keymap.set [:i :s] :<C-h> #(if (snippy.can_jump -1)
                                                                  "<Plug>(snippy-previous)"
                                                                  "<ESC>I") {:expr true}))}
  "ZhiyuanLck/smart-pairs" {:event "VeryLazy"
                            :config #(require "dotfiles.plugin.auto-pairs")}
  "stevearc/oil.nvim" {:cmd "Oil"
                       :dependencies [:nvim-tree/nvim-web-devicons]
                       :opts {:columns ["icon" "permissions" "size" "mtime"]}}
  "monkoose/matchparen.nvim" {:event "VeryLazy"
                              :config true}
  "ibhagwan/fzf-lua" {:cmd "FzfLua"
                      :dependencies ["nvim-tree/nvim-web-devicons"]
                      :opts {:winopts {:split "bot new"
                                       :border "single"}}
                      :init #(let [fzf (require "fzf-lua")]
                               (map :n :<leader>ff fzf.files)
                               (map :n :<leader>fp #(fzf.files {:cwd "~/.config/nvim/"}))
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
  "nvim-tree/nvim-web-devicons" {:event "VeryLazy"
                                 :config #(require "dotfiles.plugin.devicons")}
  "tpope/vim-fugitive" {:event "VeryLazy"}
  "guns/vim-sexp" {:ft util.lisp-language
                   :dependencies ["tpope/vim-sexp-mappings-for-regular-people"]
                   :init
                   (fn []
                     (set vim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet,racket")
                     (set vim.g.sexp_enable_insert_mode_mappings 0))}
  "svban/YankAssassin.vim" {:event "VeryLazy"}
  "kana/vim-textobj-user" {:event "VeryLazy"
                           :dependencies ["glts/vim-textobj-comment"
                                          "Julian/vim-textobj-variable-segment"]}
  "AndrewRadev/linediff.vim" {:cmd "Linediff"}
  "tyru/open-browser.vim" {:keys "<Plug>(openbrowser-smart-search)"}
  "kevinhwang91/nvim-ufo" {:dependencies ["kevinhwang91/promise-async"]
                           :config
                           #(let [ufo (require "ufo")]
                              (map :n :zR ufo.openAllFolds)
                              (map :n :zM ufo.closeAllFolds)
                              (local ftmap
                                     {:vim "indent"
                                      :fennel "treesitter"
                                      :python "indent"
                                      :git ""})
                              (ufo.setup {:provider_selector (fn [bufnr filetype buftype]
                                                               (. ftmap filetype))}))}
  "kevinhwang91/nvim-bqf" {:ft "qf"
                           :init #(require "dotfiles.plugin.bqf")}
  "RRethy/vim-illuminate" {:event "BufReadPost"
                           :config
                           #(let [illuminate (require "illuminate")]
                              (illuminate.configure
                                {:providers [:lsp :regex]
                                 :modes_denylist [:i]
                                 :large_file_curoff 10000
                                 :large_file_overrides nil}))}
  "neovim/nvim-lspconfig" {:event "BufReadPre"
                           :dependencies ["hrsh7th/cmp-nvim-lsp"
                                          "glepnir/lspsaga.nvim"]
                           :config #(require "dotfiles.lspconfig")}
  "glepnir/lspsaga.nvim" {:event "BufRead"
                          :dependencies ["nvim-tree/nvim-web-devicons"
                                         "nvim-treesitter/nvim-treesitter"]
                          :config #(require "dotfiles.plugin.lspsaga")}
  "abecodes/tabout.nvim" {:event "VeryLazy"
                          :opts {}}
  "lukas-reineke/indent-blankline.nvim" {:event "BufReadPost"
                                         :config #(require "dotfiles.plugin.indent")}
  "numToStr/Comment.nvim" {:event "VeryLazy" :config true}
  "mbbill/undotree" {:cmd "UndotreeShow"}
  "NvChad/nvim-colorizer.lua" {:cmd "ColorizerToggle"}
  "tpope/vim-repeat" {:event "VeryLazy"}
  "wlangstroth/vim-racket" {:ft "scheme"}
  "kylechui/nvim-surround" {:opts {:move_cursor false}}
  "mhinz/vim-grepper" {:keys ["gs"]
                       :config #(require "dotfiles.plugin.grepper")}
  "karb94/neoscroll.nvim" {:event "VeryLazy"
                           :config true}
  "lewis6991/gitsigns.nvim" {:event "BufReadPre"
                             :config #(require "dotfiles.plugin.gitsigns")}
  "akinsho/nvim-toggleterm.lua" {:config #(require "dotfiles.plugin.terminal")}
  "ggandor/leap.nvim" {:event "VeryLazy"
                       :config
                       (fn [_ opts]
                         (let [leap (require "leap")]
                           (each [k v (pairs opts)]
                             (tset leap.opts k v))
                           (leap.set_default_keymaps)))}
  "booperlv/nvim-gomove" {:event "VeryLazy" 
                          :config #(require "dotfiles.plugin.move")}
  "zegervdv/nrpattern.nvim" {:keys ["<C-a>" "<C-x>"]
                             :config #(let [nrpattern (require "nrpattern")]
                                        (nrpattern.setup))}
  "ThePrimeagen/harpoon" {:keys ["<leader>uu" "<leader>ua" "<leader>un"
                                 "<leader>up" "<leader>tc"]
                          :dependencies ["nvim-lua/plenary.nvim"]
                          :config #(require "dotfiles.plugin.harpoon")}
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
                           :config #(require "dotfiles.plugin.hydra")}
  "cshuaimin/ssr.nvim" {:keys ["<leader>sr"]
                        :config
                        #(let [ssr (require "ssr")]
                           (map [:n :x] "<leader>sr" ssr.open))}
  "dhruvasagar/vim-table-mode" {:cmd "TableModeToggle"
                                :init (fn [] (set vim.g.table_mode_corner "|"))}
  "glepnir/dashboard-nvim" {:event "VimEnter"
                            :config #(require "dotfiles.plugin.dashboard")})
