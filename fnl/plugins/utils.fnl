(import-macros {: tx : map} :config.macros)

(set vim.g.grepper {:tools [:rg :git]
                    :dir "repo,file"
                    :simple_prompt 1
                    :searchreg 1
                    :stop 50000
                    :rg {:grepprg "rg -H --no-heading --vimgrep --smart-case"
                         :grepformat "%f:%l:%c:%m,%f:%l:%m"}})

(vim.cmd "let g:grepper.repo = ['.git', '.hg', '.svn', 'stack.yaml', 'dune-project', '.ccls-root', 'Cargo.toml', 'compile_commands.json']")

(vim.cmd "aug Grepper
au!
au User Grepper ++nested call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\\%#' . getreg('/')}}}) | bo cope
aug END")

(vim.cmd "command! Todo :Grepper -noprompt -tool git -grepprg git grep -nIi '\\(TODO\\|FIXME\\)'")

[(tx "mhinz/vim-grepper" {:keys [(tx "gs" "<plug>(GrepperOperator)" {:mode [:n :x :o]})]})
 (tx "mbbill/undotree" {:cmd "UndotreeShow"
                        :config #(map :n :<leader>ou ":UndotreeShow<cr>:UndotreeFocus<cr>")})
 (tx "ThePrimeagen/harpoon" {:keys ["<leader>uu" "<leader>ua" "<leader>un"
                                    "<leader>up" "<leader>tc"]
                             :branch "harpoon2"
                             :dependencies ["nvim-lua/plenary.nvim"]
                             :config #(let [harpoon (require "harpoon")]
                                        (harpoon:setup)
                                        (map :n :<leader>ua #(: (harpoon:list) :add))
                                        (map :n :<leader>uu #(harpoon.ui:toggle_quick_menu (harpoon:list))))})
 (tx "kazhala/close-buffers.nvim" {:keys ["<leader>bk" "<leader>bo"]
                                   :config #(let [close-buffers (require "close_buffers")]
                                              (map :n :<leader>bk #(close-buffers.delete {:type :this}))
                                              (map :n :<leader>bo #(close-buffers.delete {:type :hidden})))})
 (tx "anuvyklack/hydra.nvim" {:event "VeryLazy"
                              :dependencies ["anuvyklack/keymap-layer.nvim"
                                             "mrjones2014/smart-splits.nvim"]
                              :config #(let [(_ hydra) (pcall require "hydra")]
                                         (do
                                           (hydra {:name "Side scroll"
                                                   :mode :n
                                                   :body :z
                                                   :heads [[:h :5zh]
                                                           [:l :5zl {:desc "←/→"}]
                                                           [:H :zH]
                                                           [:L :zL {:desc "half screen ←/→"}]]})

                                           (let [(_ splits) (pcall require "smart-splits")]
                                             (hydra {:name "smooth scroll"
                                                     :mode :n
                                                     :body :<C-w>
                                                     :heads [[:< splits.resize_left]
                                                             [:> splits.resize_right]
                                                             [:+ splits.resize_up]
                                                             [:- splits.resize_down]]}))))})
 (tx "dhruvasagar/vim-table-mode" {:cmd "TableModeToggle"})]
