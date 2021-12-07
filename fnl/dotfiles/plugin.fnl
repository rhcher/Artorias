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
  :Olical/nvim-local-fennel {}
  :famiu/feline.nvim {:mod :feline}
  :clojure-vim/clojure.vim {:ft :clojure}
  :clojure-vim/vim-jack-in {}
  :guns/vim-sexp {:mod :sexp}
  :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-nvim-lsp
                                :hrsh7th/cmp-buffer
                                :hrsh7th/cmp-path
                                :PaterJason/cmp-conjure
                                :dcampos/cmp-snippy
                                :hrsh7th/cmp-cmdline
                                :hrsh7th/cmp-nvim-lsp-document-symbol]
                     :mod :cmp}
  :jiangmiao/auto-pairs {:mod :auto-pairs}
  :lewis6991/impatient.nvim {}
  :rhcher/srcery-vim {}
  :mbbill/undotree {:mod :undotree}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :norcalli/nvim-colorizer.lua {:mod :colorizer}
  :nvim-telescope/telescope.nvim {:mod :telescope :requires [[:nvim-lua/popup.nvim] [:nvim-lua/plenary.nvim]]}
  :radenling/vim-dispatch-neovim {}
  :tpope/vim-abolish {}
  :tpope/vim-commentary {}
  :tpope/vim-dispatch {}
  :tpope/vim-fugitive {:mod :fugitive}
  :tpope/vim-repeat {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :tpope/vim-sleuth {:mod :sleuth}
  :wbthomason/packer.nvim {}
  :wlangstroth/vim-racket {}
  :kyazdani42/nvim-tree.lua {:mod :nvimtree :requires :kyazdani42/nvim-web-devicons}
  :eraserhd/parinfer-rust {:run "cargo build --release" :cmd :ParinferOn}
  :bakpakin/fennel.vim {:ft :fennel}
  :dcampos/nvim-snippy {}
  :honza/vim-snippets {}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate" :mod :treesitter}
  :kevinhwang91/nvim-bqf {:branch :dev :mod :bqf}
  :wellle/targets.vim {:mod :targets}
  :machakann/vim-sandwich {:mod :sandwich}
  :TimUntersberger/neogit {:mod :neogit}
  :mhinz/vim-grepper {:mod :grepper}
  :neovimhaskell/haskell-vim {:ft :haskell}
  :andymass/vim-matchup {:mod :matchup}
  :karb94/neoscroll.nvim {:mod :neoscroll}
  :AndrewRadev/splitjoin.vim {:mod :splitjoin}
  :lewis6991/gitsigns.nvim {:mod :gitsigns}
  :onsails/lspkind-nvim {}
  :akinsho/nvim-toggleterm.lua {:mod :terminal}
  :ggandor/lightspeed.nvim {})
