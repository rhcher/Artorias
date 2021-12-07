(module dotfiles.plugin.sandwich
  {autoload {nvim aniseed.nvim}})

(vim.cmd "let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)")
(vim.cmd "runtime macros/sandwich/keymap/surround.vim")
