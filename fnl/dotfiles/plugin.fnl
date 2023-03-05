(module dotfiles.plugin
  {autoload {a aniseed.core
             util dotfiles.util
             : lazy}
   import-macros [[{: map} :dotfiles.macros]]})


(defn use [...]
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
        (if (not= (a.get opts "dir" nil) nil)
            (table.insert plugins opts)
            (table.insert plugins (a.assoc opts 1 name)))))
    (lazy.setup plugins)))

(use
  "folke/lazy.nvim" {}
  "vim-lsp-cxx-highlight" {:dir "/home/rhcher/workspace/vim-lsp-cxx-highlight/"
                           :ft [:c :cpp]}
  "Olical/aniseed" {:event "VeryLazy" :branch "develop"}
  "Olical/conjure" {:event "VeryLazy" :branch "develop"}
  "glepnir/whiskyline.nvim" {:event "VimEnter"
                             :config true :dependencies ["nvim-tree/nvim-web-devicons"]}
  "junegunn/fzf" {:event "VeryLazy" :build "./install --bin"}
  "karb94/neoscroll.nvim" {:event "VeryLazy"
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
                      :dependencies ["MunifTanjim/nui.nvim"]
                      :keys [{1 "<S-Enter>"
                              2 #((. (require "noice") :redirect) (vim.fn.getcmdline))
                              :mode "c"}]
                      :opts {:lsp {:override {"vim.lsp.util.convert_input_to_markdown_lines" true
                                              "vim.lsp.util.stylize_markdown" true
                                              "cmp.entry.get_documentation" true}}
                             :presets {:bottom_search true
                                       :command_palette true
                                       :long_message_to_split true}
                             :messages {:enabled false}}}
  "nvim-treesitter/nvim-treesitter" {:event "BufReadPost"
                                     :version false
                                     :build ":TSUpdate"
                                     :mod "treesitter"}
  "rhcher/srcery.nvim" {:config #(vim.cmd.colorscheme "srcery")
                        :priority 1000}
  "rhcher/vim-paper" {:lazy true}
  "rebelot/kanagawa.nvim" {:lazy true}
                           ; :config #(vim.cmd.colorscheme "kanagawa")
                           ; :priority 1000}
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
                      :mod "cmp"}
  "echasnovski/mini.ai" {:event "VeryLazy"
                         :dependencies [{1 "nvim-treesitter/nvim-treesitter-textobjects"
                                         :init #(let [loader (require "lazy.core.loader")]
                                                  (loader.disable_rtp_plugin "nvim-treesitter-textobjects"))}]
                         :opts #(let [ai (require "mini.ai")]
                                  {:n_lines 500
                                   :search_method "cover_or_nearest"
                                   :custom_textobjects {:o (ai.gen_spec.treesitter
                                                             {:a ["@block.outer" "@conditional.outer" "@loop.outer"]
                                                              :i ["@block.inner" "@conditional.inner" "@loop.inner"]} {})
                                                        :a (ai.gen_spec.treesitter {:a "@parameter.outer" :i "@parameter.inner"})
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
                            :mod "auto-pairs"}
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
  "nvim-tree/nvim-web-devicons" {:event "VeryLazy" :mod "devicons"}
  "tpope/vim-fugitive" {:cmd "Git"}
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
                           :mod "bqf"}
  "RRethy/vim-illuminate" {:event "BufReadPost"
                           :config
                           #(let [illuminate (require "illuminate")]
                              (illuminate.configure
                                {:providers [:lsp :regex]
                                 :modes_denylist [:i]
                                 :large_file_curoff 10000
                                 :large_file_overrides nil}))}
  "neovim/nvim-lspconfig" {:event "BufReadPre"
                           :dependencies ["hrsh7th/cmp-nvim-lsp"]
                           :config #(require "dotfiles.lspconfig")}
  "glepnir/lspsaga.nvim" {:event "BufRead"
                          :dependencies ["nvim-tree/nvim-web-devicons"
                                         "nvim-treesitter/nvim-treesitter"]
                          :mod "lspsaga"}
  "abecodes/tabout.nvim" {:event "VeryLazy"
                          :opts {}}
  "lukas-reineke/indent-blankline.nvim" {:event "BufReadPost"
                                         :mod "indent"}
  "numToStr/Comment.nvim" {:event "VeryLazy" :config true}
  "mbbill/undotree" {:cmd "UndotreeShow"}
  "NvChad/nvim-colorizer.lua" {:cmd "ColorizerToggle"}
  "tpope/vim-repeat" {:event "VeryLazy"}
  "wlangstroth/vim-racket" {:ft "scheme"}
  "kylechui/nvim-surround" {:opts {:move_cursor false}}
  "mhinz/vim-grepper" {:keys ["gs"] :mod "grepper"}
  "lewis6991/gitsigns.nvim" {:event "BufReadPre" :mod "gitsigns"}
  "akinsho/nvim-toggleterm.lua" {:mod "terminal"}
  "ggandor/leap.nvim" {:event "VeryLazy"
                       :keys [{1 "s" :mode [:n :x :o] :desc "Leap forward to"}
                              {1 "S" :mode [:n :x :o] :desc "Leap backward to"}]
                       :config
                       (fn [_ opts]
                         (let [leap (require "leap")]
                           (each [k v (pairs opts)]
                             (tset leap.opts k v))
                           (leap.add_default_mappings)))}
  "booperlv/nvim-gomove" {:event "VeryLazy" :mod "move"}
  "zegervdv/nrpattern.nvim" {:keys ["<C-a>" "<C-x>"]
                             :config #(let [nrpattern (require "nrpattern")]
                                        (nrpattern.setup))}
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
                        #(let [ssr (require "ssr")]
                           (map [:n :x] "<leader>sr" ssr.open))}
  "dhruvasagar/vim-table-mode" {:cmd "TableModeToggle"
                                :init (fn [] (set vim.g.table_mode_corner "|"))}
  "glepnir/dashboard-nvim" {:event "VimEnter" :mod "dashboard"})
