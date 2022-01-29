(module dotfiles.plugin.sandwich)

(vim.cmd "let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)")
(vim.cmd "runtime macros/sandwich/keymap/surround.vim")
