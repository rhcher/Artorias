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
  "Olical/aniseed" {:branch "develop"}
  "Olical/conjure" {:branch "develop"}
  "feline-nvim/feline.nvim" {:config true}
  "nvim-treesitter/nvim-treesitter" {:build ":TSUpdate"
                                     :config (fn [] (require "dotfiles.plugin.treesitter"))}
  "nvim-treesitter/nvim-treesitter-textobjects" {:dependencies
                                                 ["nvim-treesitter/nvim-treesitter"]}
  "rhcher/srcery.nvim" {:config (fn [] (vim.cmd.colorscheme "srcery"))
                        :priority 1000}
  "rhcher/vim-paper" {:lazy true}
  "rebelot/kanagawa.nvim" {:lazy true}
                           ;; :config (fn [] (vim.cmd.colorscheme "kanagawa"))
                           ;; :priority 1000}
  "eraserhd/parinfer-rust" {:ft util.lisp-language
                            :build "cargo build --release"}
  "hrsh7th/nvim-cmp" {:dependencies [:hrsh7th/cmp-nvim-lsp
                                     :hrsh7th/cmp-buffer
                                     :hrsh7th/cmp-path
                                     :PaterJason/cmp-conjure
                                     :hrsh7th/cmp-cmdline
                                     :onsails/lspkind-nvim]
                      :config (fn [] (require "dotfiles.plugin.cmp"))}
  "dcampos/nvim-snippy" {:init
                         (fn []
                           (let [snippy (require :snippy)]
                             (vim.keymap.set [:i :s] :<C-l> #(if (snippy.can_jump 1)
                                                                 "<Plug>(snippy-next)"
                                                                 "<ESC>A") {:expr true})
                             (vim.keymap.set [:i :s] :<C-h> #(if (snippy.can_jump -1)
                                                                 "<Plug>(snippy-previous)"
                                                                 "<ESC>I") {:expr true})))}
  "ZhiyuanLck/smart-pairs" {:config (fn [] (require "dotfiles.plugin.auto-pairs"))}
  "stevearc/oil.nvim" {:dependencies [:nvim-tree/nvim-web-devicons]
                       :config true}
  "nvim-tree/nvim-web-devicons" {:config (fn [] (require "dotfiles.plugin.devicons"))}
  "kevinhwang91/nvim-hlslens" {:event "CmdlineEnter"
                               :config true}
  "monkoose/matchparen.nvim" {:config true}
  "ibhagwan/fzf-lua" {:dependencies ["nvim-tree/nvim-web-devicons"]
                      :opts {:winopts {:split "bot new"
                                       :border "single"}}
                      :init (fn []
                              (let [fzf (require "fzf-lua")]
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
                                (map :n :<leader>fg fzf.git_bcommits)))}
  "tpope/vim-fugitive" {}
  "guns/vim-sexp" {:ft util.lisp-language
                   :dependencies ["tpope/vim-sexp-mappings-for-regular-people"]
                   :init
                   (fn []
                     (set vim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet,racket")
                     (set vim.g.sexp_enable_insert_mode_mappings 0))}
  "svban/YankAssassin.vim" {}
  "kana/vim-textobj-user" {:dependencies ["Julian/vim-textobj-variable-segment"
                                          "glts/vim-textobj-comment"]}
  "AndrewRadev/linediff.vim" {:cmd "Linediff"}
  "tyru/open-browser.vim" {:keys "<Plug>(openbrowser-smart-search)"}
  "kevinhwang91/nvim-ufo" {:dependencies ["kevinhwang91/promise-async"]
                           :config
                           (fn []
                             (let [ufo (require "ufo")]
                               (map :n :zR ufo.openAllFolds)
                               (map :n :zM ufo.closeAllFolds)
                               (local ftmap
                                      {:vim "indent"
                                       :fennel "treesitter"
                                       :python "indent"
                                       :git ""})
                               (ufo.setup {:provider_selector (fn [bufnr filetype buftype]
                                                                (. ftmap filetype))})))}
  "kevinhwang91/nvim-bqf" {:ft "qf"
                           :init (fn [] (require "dotfiles.plugin.bqf"))}
  "RRethy/vim-illuminate" {:config
                           (fn []
                             (let [illuminate (require "illuminate")]
                               (illuminate.configure
                                 {:providers [:lsp :regex]
                                  :modes_denylist [:i]
                                  :large_file_curoff 10000
                                  :large_file_overrides nil})))}
  "neovim/nvim-lspconfig" {:dependencies ["hrsh7th/cmp-nvim-lsp"
                                          "glepnir/lspsaga.nvim"]
                           :config (fn [] (require "dotfiles.lspconfig"))}
  "glepnir/lspsaga.nvim" {:event "BufRead"
                          :dependencies ["nvim-tree/nvim-web-devicons"
                                         "nvim-treesitter/nvim-treesitter"]
                          :config (fn [] (require "dotfiles.plugin.lspsaga"))}
  "abecodes/tabout.nvim" {:opts {}}
  "lukas-reineke/indent-blankline.nvim" {:config (fn [] (require "dotfiles.plugin.indent"))}
  "numToStr/Comment.nvim" {:config true}
  "mbbill/undotree" {:cmd "UndotreeShow"}
  "NvChad/nvim-colorizer.lua" {:cmd "ColorizerToggle"}
  "tpope/vim-repeat" {}
  "wlangstroth/vim-racket" {:ft "scheme"}
  "j-hui/fidget.nvim" {:config true}
  "kylechui/nvim-surround" {:opts {:move_cursor false}}
  "mhinz/vim-grepper" {:keys ["gs"]
                       :config (fn [] (require "dotfiles.plugin.grepper"))}
  "karb94/neoscroll.nvim" {:config true}
  "lewis6991/gitsigns.nvim" {:config (fn [] (require "dotfiles.plugin.gitsigns"))}
  "akinsho/nvim-toggleterm.lua" {:config (fn [] (require "dotfiles.plugin.terminal"))}
  "ggandor/leap.nvim" {:config
                       (fn []
                         (let [leap (require "leap")]
                           (leap.set_default_keymaps)))}
  "booperlv/nvim-gomove" {:config (fn [] (require "dotfiles.plugin.move"))}
  "zegervdv/nrpattern.nvim" {:config true}
  "ThePrimeagen/harpoon" {:dependencies ["nvim-lua/plenary.nvim"]
                          :config (fn [] (require "dotfiles.plugin.harpoon"))}
  "danymat/neogen" {:opts {:snippet_engine "snippy"}}
  "kazhala/close-buffers.nvim" {:config
                                (fn []
                                  (let [close-buffers (require "close_buffers")]
                                    (map :n :<leader>bk (fn [] (close-buffers.delete {:type :this})))
                                    (map :n :<leader>bo (fn [] (close-buffers.delete {:type :hidden})))))}
  "anuvyklack/hydra.nvim" {:dependencies ["anuvyklack/keymap-layer.nvim"
                                          "mrjones2014/smart-splits.nvim"]
                           :config (fn [] (require "dotfiles.plugin.hydra"))}
  "cshuaimin/ssr.nvim" {:config
                        (fn []
                          (let [ssr (require "ssr")]
                            (map [:n :x] "<leader>sr" ssr.open)))}
  "dhruvasagar/vim-table-mode" {:init (fn [] (set vim.g.table_mode_corner "|"))}
  "glepnir/dashboard-nvim" {:event "VimEnter"
                            :config (fn [] (require "dotfiles.plugin.dashboard"))})
