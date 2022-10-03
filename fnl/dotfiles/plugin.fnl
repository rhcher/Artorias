(module dotfiles.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util dotfiles.util
             : packer}})

(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :dotfiles.plugin. name))]
    (when (not ok?)
      (print (.. "dotfiles error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))
  nil)

;; Plugins to be managed by packer.
(use
  :Olical/aniseed {:branch :develop}
  :Olical/conjure {:branch :develop}
  :rhcher/srcery-vim {}
  :rhcher/vim-paper {:opt true}
  :nvim-lua/plenary.nvim {}
  :wbthomason/packer.nvim {}
  :lewis6991/impatient.nvim {}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate" :mod :treesitter}
  :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-buffer
                                :hrsh7th/cmp-path
                                :PaterJason/cmp-conjure
                                :hrsh7th/cmp-cmdline
                                :hrsh7th/cmp-nvim-lsp-signature-help
                                :onsails/lspkind-nvim]
                     :mod :cmp}
  :dcampos/nvim-snippy {}
  :feline-nvim/feline.nvim {}
  :mbbill/undotree {:cmd :UndotreeShow}
  :norcalli/nvim-colorizer.lua {:cmd :ColorizerToggle}
  :nvim-lua/popup.nvim {}
  :ibhagwan/fzf-lua {}
  :guns/vim-sexp {:ft util.lisp-language}
  :tpope/vim-repeat {}
  :tpope/vim-sexp-mappings-for-regular-people {:after :vim-sexp}
  :tpope/vim-fugitive {}
  :wlangstroth/vim-racket {:ft :scheme}
  :kyazdani42/nvim-web-devicons {:mod :devicons}
  :kyazdani42/nvim-tree.lua {:mod :nvimtree :requires :kyazdani42/nvim-web-devicons}
  :gpanders/nvim-parinfer {:ft util.lisp-language}
  :kevinhwang91/nvim-bqf {:mod :bqf}
  :wellle/targets.vim {}
  :kylechui/nvim-surround {}
  :mhinz/vim-grepper {:mod :grepper}
  :neovimhaskell/haskell-vim {:ft :haskell}
  :karb94/neoscroll.nvim {}
  :lewis6991/gitsigns.nvim {:mod :gitsigns}
  :akinsho/nvim-toggleterm.lua {:mod :terminal}
  :ggandor/leap.nvim {}
  :ZhiyuanLck/smart-pairs {:mod :auto-pairs}
  :ocaml/vim-ocaml {:ft :ocaml}
  :numToStr/Comment.nvim {}
  :monkoose/matchparen.nvim {}
  :svban/YankAssassin.vim {}
  :hrsh7th/vim-searchx {:mod :searchx}
  :metakirby5/codi.vim {:cmd :Codi}
  :booperlv/nvim-gomove {:mod :move}
  :kana/vim-textobj-user {}
  :Julian/vim-textobj-variable-segment {}
  :glts/vim-textobj-comment {}
  :zegervdv/nrpattern.nvim {}
  :j-hui/fidget.nvim {}
  :tommcdo/vim-exchange {:keys ["<Plug>(Exchange)" "<Plug>(Exchange)" "<Plug>(ExchangeClear)" "<Plug>(ExchangeLine)"]}
  :junegunn/fzf {:run "./install --bin"}
  :AndrewRadev/linediff.vim {:cmd :Linediff}
  :tyru/open-browser.vim {:keys "<Plug>(openbrowser-smart-search)"}
  :ThePrimeagen/harpoon {:mod :harpoon}
  :danymat/neogen {}
  :kevinhwang91/nvim-hlslens {:event :CmdlineEnter}
  :harrygallagher4/aniseed-ts-queries.nvim {:ft :fennel}
  :kazhala/close-buffers.nvim {:mod :close_buffers}
  :jedrzejboczar/possession.nvim {}
  :jackguo380/vim-lsp-cxx-highlight {:ft [:c :cpp]}
  :lambdalisue/suda.vim {:cmd :SudaWrite}
  ;; :glepnir/lspsaga.nvim {}
  "~/workspace/lspsaga.nvim/" {}
  :anuvyklack/hydra.nvim {:mod :hydra :requires [:anuvyklack/keymap-layer.nvim]}
  :kevinhwang91/nvim-ufo {:requires [:kevinhwang91/promise-async]}
  :lukas-reineke/indent-blankline.nvim {:mod :indent}
  :mrjones2014/smart-splits.nvim {}
  :dhruvasagar/vim-table-mode {:cmd :TableModeToggle}
  :abecodes/tabout.nvim {}
  :sakhnik/nvim-gdb {:run "./install.sh"}
  :RRethy/vim-illuminate {})
