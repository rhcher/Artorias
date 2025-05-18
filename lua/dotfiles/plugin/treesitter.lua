-- [nfnl] fnl/dotfiles/plugin/treesitter.fnl
local _, tsconfigs = pcall(require, "nvim-treesitter.configs")
return tsconfigs.setup({ensure_installed = {"c", "cpp", "rust", "lua", "python", "cmake", "markdown", "markdown_inline", "vim", "fennel", "query", "ocaml", "ocaml_interface", "haskell", "scheme", "regex", "bash", "luap", "racket", "html"}, highlight = {enable = true, disable = {"c", "cpp", "help", "lua"}, additional_vim_regex_highlighting = false}, indent = {enable = false}})
