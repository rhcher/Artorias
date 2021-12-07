(module dotfiles.plugin.matchup)

(set vim.g.matchup_matchparen_deferred true)

(vim.cmd "let g:matchup_delim_noskips = 2")
(vim.cmd "autocmd FileType scheme,racket,fennel,clojure let b:matchup_matchparen_hi_surround_always = 1")
(vim.cmd "let g:matchup_matchparen_offscreen = {}")

(vim.api.nvim_set_keymap :x :i<Tab> "<plug>(matchup-i%)" {:noremap false})
(vim.api.nvim_set_keymap :x :a<Tab> "<plug>(matchup-a%)" {:noremap false})
(vim.api.nvim_set_keymap :o :i<Tab> "<plug>(matchup-i%)" {:noremap false})
(vim.api.nvim_set_keymap :o :a<Tab> "<plug>(matchup-a%)" {:noremap false})
