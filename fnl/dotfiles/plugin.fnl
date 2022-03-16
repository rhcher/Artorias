(module dotfiles.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util dotfiles.util
             packer packer}})

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
  :Olical/conjure {:branch :develop :mod :conjure}
  :wbthomason/packer.nvim {}
  :lewis6991/impatient.nvim {}
  :feline-nvim/feline.nvim {:mod :feline}
  :guns/vim-sexp {:mod :sexp}
  :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-buffer
                                :hrsh7th/cmp-path
                                :PaterJason/cmp-conjure
                                :dcampos/cmp-snippy
                                :hrsh7th/cmp-cmdline
                                :hrsh7th/cmp-nvim-lsp-signature-help]
                     :mod :cmp}
  :dcampos/nvim-snippy {}
  :honza/vim-snippets {}
  :rhcher/srcery-vim {}
  :mbbill/undotree {:mod :undotree}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :norcalli/nvim-colorizer.lua {:mod :colorizer}
  :nvim-lua/popup.nvim {}
  :nvim-lua/plenary.nvim {}
  :ibhagwan/fzf-lua {:mod :fzf}
  :tpope/vim-abolish {}
  :tpope/vim-repeat {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :Darazaki/indent-o-matic {:mod :indent}
  :wlangstroth/vim-racket {}
  :kyazdani42/nvim-tree.lua {:mod :nvimtree :requires :kyazdani42/nvim-web-devicons}
  :eraserhd/parinfer-rust {:run "cargo build --release" :cmd :ParinferOn}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate" :mod :treesitter}
  :kevinhwang91/nvim-bqf {:mod :bqf}
  :wellle/targets.vim {:mod :targets}
  :machakann/vim-sandwich {:mod :sandwich}
  :TimUntersberger/neogit {:mod :neogit}
  :mhinz/vim-grepper {:mod :grepper}
  :neovimhaskell/haskell-vim {:ft :haskell}
  :karb94/neoscroll.nvim {:mod :neoscroll}
  :AndrewRadev/splitjoin.vim {:mod :splitjoin}
  :lewis6991/gitsigns.nvim {:mod :gitsigns}
  :onsails/lspkind-nvim {}
  :akinsho/nvim-toggleterm.lua {:mod :terminal}
  :ggandor/lightspeed.nvim {:mod :lightspeed}
  :ZhiyuanLck/smart-pairs {:mod :auto-pairs}
  :ocaml/vim-ocaml {:ft :ocaml}
  ;; :ojroques/vim-oscyank {}
  :numToStr/Comment.nvim {:mod :nvim_comment}
  :monkoose/matchparen.nvim {:mod :matchparen}
  :rhcher/vim-paper {}
  :mfussenegger/nvim-lint {:mod :lint}
  :svban/YankAssassin.vim {}
  :kazhala/close-buffers.nvim {:mod :close_buffers}
  :hrsh7th/vim-searchx {:mod :searchx}
  :metakirby5/codi.vim {:mod :codi}
  :booperlv/nvim-gomove {:mod :move}
  :kana/vim-textobj-user {}
  :Julian/vim-textobj-variable-segment {}
  :glts/vim-textobj-comment {}
  :zegervdv/nrpattern.nvim {:mod :nrpattern}
  :j-hui/fidget.nvim {:mod :fidget}
  :tommcdo/vim-exchange {}
  :junegunn/fzf {:run "./install --bin"}
  :hoschi/yode-nvim {:mod :yode})
