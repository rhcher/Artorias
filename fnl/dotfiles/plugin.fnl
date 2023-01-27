(module dotfiles.plugin
  {autoload {a aniseed.core
             util dotfiles.util}
   require-macros [dotfiles.macros]})

(def plugins [])
(table.insert plugins "folke/lazy.nvim")
(table.insert plugins {1 "Olical/aniseed" :branch "develop"})
(table.insert plugins {1 "Olical/conjure" :branch "develop"
                       :init
                       (fn []
                         (set vim.g.conjure#eval#result_register "*")
                         (set vim.g.conjure#log#botright true)
                         (set vim.g.conjure#client#scheme#stdio#command "petite")
                         (set vim.g.conjure#client#scheme#stdio#prompt_pattern "> $?")
                         (if (= (. (vim.fs.find "nvim" {:upward true}) 1)
                                (vim.fn.stdpath "config"))
                           (do
                             (set vim.g.conjure#mapping#doc_word false)
                             (set vim.g.conjure#filetype#fennel "conjure.client.fennel.aniseed"))
                           (set vim.g.conjure#filetype#fennel "conjure.client.fennel.stdio"))
                         (set vim.g.conjure#client#scheme#stdio#value_prefix_pattern false))})
(table.insert plugins {1 "rhcher/srcery.nvim" :priority 1000
                       :config (fn [] (vim.cmd.colorscheme "srcery"))})

(table.insert plugins {1 "rebelot/kanagawa.nvim"
                       :lazy true})

(table.insert plugins {1 "rhcher/vim-paper"
                       :lazy true})

(table.insert plugins {1 "nvim-treesitter/nvim-treesitter"
                       :build ":TSUpdate"
                       :config (fn [] (require "dotfiles.plugin.treesitter"))})

(table.insert plugins {1 "nvim-treesitter/nvim-treesitter-textobjects"
                       :dependencies "nvim-treesitter/nvim-treesitter"})

(table.insert plugins {1 "hrsh7th/nvim-cmp"
                       :dependencies [:hrsh7th/cmp-nvim-lsp
                                      :hrsh7th/cmp-buffer
                                      :hrsh7th/cmp-path
                                      :PaterJason/cmp-conjure
                                      :hrsh7th/cmp-cmdline
                                      :onsails/lspkind-nvim]
                       :config (fn [] (require "dotfiles.plugin.cmp"))})

(table.insert plugins {1 "dcampos/nvim-snippy"
                       :init
                       (fn []
                         (let [snippy (require :snippy)]
                           (vim.keymap.set [:i :s] :<C-l> #(if (snippy.can_jump 1)
                                                             "<Plug>(snippy-next)"
                                                             "<ESC>A") {:expr true})
                           (vim.keymap.set [:i :s] :<C-h> #(if (snippy.can_jump -1)
                                                             "<Plug>(snippy-previous)"
                                                             "<ESC>I") {:expr true})))})
(table.insert plugins {1 "stevearc/oil.nvim"
                       :dependencies {1 :nvim-tree/nvim-web-devicons
                                      :config (fn [] (require "dotfiles.plugin.devicons"))}
                       :config true})
(table.insert plugins {1 "gpanders/nvim-parinfer"
                       :ft util.lisp-language})

(table.insert plugins {1 "feline-nvim/feline.nvim"
                       :config true})

(table.insert plugins {1 "monkoose/matchparen.nvim"
                       :config true})

(table.insert plugins {1 "ibhagwan/fzf-lua"
                       :dependencies ["nvim-tree/nvim-web-devicons"]
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
                                 (map :n :<leader>fg fzf.git_bcommits)))})

(table.insert plugins {1 "ZhiyuanLck/smart-pairs"
                       :config (fn [] (require "dotfiles.plugin.auto-pairs"))})
(table.insert plugins {1 "guns/vim-sexp"
                       :ft util.lisp-language
                       :dependencies ["tpope/vim-sexp-mappings-for-regular-people"]
                       :init
                       (fn []
                         (set vim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet,racket")
                         (set vim.g.sexp_enable_insert_mode_mappings 0))})

(table.insert plugins "tpope/vim-fugitive")
(table.insert plugins "wellle/targets.vim")
(table.insert plugins "svban/YankAssassin.vim")
(table.insert plugins {1 "kana/vim-textobj-user"
                       :dependencies ["Julian/vim-textobj-variable-segment"
                                      "glts/vim-textobj-comment"]})

(table.insert plugins {1 "AndrewRadev/linediff.vim"
                       :cmd "Linediff"})

(table.insert plugins {1 "tyru/open-browser.vim"
                       :keys "<Plug>(openbrowser-smart-search)"})

(table.insert plugins {1 "kevinhwang91/nvim-hlslens"
                       :event "CmdlineEnter"
                       :config true})

(table.insert plugins {1 "kevinhwang91/nvim-ufo"
                       :dependencies ["kevinhwang91/promise-async"]
                       :config (fn []
                                 (let [ufo (require "ufo")]
                                   (map :n :zR ufo.openAllFolds)
                                   (map :n :zM ufo.closeAllFolds)
                                   (local ftmap
                                     {:vim "indent"
                                      :fennel "treesitter"
                                      :python "indent"
                                      :git ""})
                                   (ufo.setup {:provider_selector (fn [bufnr filetype buftype]
                                                                    (. ftmap filetype))})))})
(table.insert plugins {1 "kevinhwang91/nvim-bqf"
                       :ft "qf"
                       :init (fn [] (require "dotfiles.plugin.bqf"))})

(table.insert plugins {1 "RRethy/vim-illuminate"
                       :config
                       (fn []
                         (let [illuminate (require "illuminate")]
                           (illuminate.configure
                             {:providers [:lsp :regex]
                              :modes_denylist [:i]
                              :large_file_curoff 10000
                              :large_file_overrides nil})))})

(table.insert plugins {1 "neovim/nvim-lspconfig"
                       :dependencies ["hrsh7th/cmp-nvim-lsp"
                                      "glepnir/lspsaga.nvim"]
                       :config (fn [] (require "dotfiles.lspconfig"))})

(table.insert plugins {:dir "/home/rhcher/workspace/vim-lsp-cxx-highlight/"
                       :ft [:c :cpp]})

(table.insert plugins {1 "abecodes/tabout.nvim"
                       :opts {}})

(table.insert plugins {1 "lukas-reineke/indent-blankline.nvim"
                       :config (fn [] (require "dotfiles.plugin.indent"))})

(table.insert plugins {1 "numToStr/Comment.nvim"
                       :config true})

(table.insert plugins {1 "mbbill/undotree"
                       :cmd "UndotreeShow"})

(table.insert plugins {1 "NvChad/nvim-colorizer.lua"
                       :cmd :ColorizerToggle})

(table.insert plugins "tpope/vim-repeat")
(table.insert plugins {1 "wlangstroth/vim-racket"
                       :ft :scheme})

(table.insert plugins {1 "wellle/targets.vim"
                       :init
                       (fn []
                         (set vim.g.targets_seekRanges "cc cr cb cB lc ac Ac lr lb ar ab rr rb bb ll al aa")
                         (set vim.g.targets_separators ", . ; : + - = ~ _ * # / | \\ &")
                         (set vim.g.targets_argOpening "[({[]")
                         (set vim.g.targets_argClosing "[]})]"))})

(table.insert plugins {1 "j-hui/fidget.nvim"
                       :config true})

(table.insert plugins {1 "kylechui/nvim-surround"
                       :opts {:move_cursor false
                              :surrounds {"(" {:add ["(" ")"]}
                                          ")" {:add ["( " " )"]}
                                          "{" {:add ["{" "}"]}
                                          "}" {:add ["{ " " }"]}
                                          "[" {:add ["[" "]"]}
                                          "]" {:add ["[ " " ]"]}}}})

;; (table.insert plugins {1 "mhinz/vim-grepper"
;;                        :config (fn [] (require "dotfiles.plugin.grepper"))})

(table.insert plugins {1 "karb94/neoscroll.nvim"
                       :config true})

(table.insert plugins {1 "lewis6991/gitsigns.nvim"
                       :config (fn [] (require "dotfiles.plugin.gitsigns"))})

(table.insert plugins {1 "akinsho/nvim-toggleterm.lua"
                       :config (fn [] (require "dotfiles.plugin.terminal"))})

(table.insert plugins {1 "ggandor/leap.nvim"
                       :config
                       (fn []
                         (let [leap (require "leap")]
                           (leap.set_default_keymaps)))})

;; (table.insert plugins {1 "hrsh7th/vim-searchx"
;;                        :config (fn [] (require "dotfiles.plugin.searchx"))})

(table.insert plugins {1 "booperlv/nvim-gomove"
                       :config (fn [] (require "dotfiles.plugin.move"))})

(table.insert plugins {1 "zegervdv/nrpattern.nvim"
                       :config true})

(table.insert plugins {1 "ThePrimeagen/harpoon"
                       :dependencies ["nvim-lua/plenary.nvim"]
                       :config (fn [] (require "dotfiles.plugin.harpoon"))})

(table.insert plugins {1 "danymat/neogen"
                       :opts {:snippet_engine "snippy"}})

(table.insert plugins {1 "kazhala/close-buffers.nvim"
                       :config
                       (fn []
                         (let [close-buffers (require "close_buffers")]
                           (map :n :<leader>bk (fn [] (close-buffers.delete {:type :this})))
                           (map :n :<leader>bo (fn [] (close-buffers.delete {:type :hidden})))))})

(table.insert plugins {1 "anuvyklack/hydra.nvim"
                       :dependencies ["anuvyklack/keymap-layer.nvim"
                                      "mrjones2014/smart-splits.nvim"]
                       :config (fn [] (require "dotfiles.plugin.hydra"))})

(table.insert plugins {1 "cshuaimin/ssr.nvim"
                       :config
                       (fn []
                         (let [ssr (require "ssr")]
                           (map [:n :x] "<leader>sr" ssr.open)))})

(table.insert plugins {1 "dhruvasagar/vim-table-mode"
                       :init (fn [] (set vim.g.table_mode_corner "|"))})

(let [lazy (require :lazy)]
  (lazy.setup plugins))
