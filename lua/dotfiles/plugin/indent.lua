-- [nfnl] Compiled from fnl/dotfiles/plugin/indent.fnl by https://github.com/Olical/nfnl, do not edit.
local indent = require("ibl")
return indent.setup({scope = {show_start = false, show_end = false}, exclude = {filetypes = {"", "help", "fennel", "packer", "lspinfo", "tsplayground", "query", "scheme", "racket", "qf", "dashboard", "markdown", "c", "cpp"}, buftypes = {"terminal", "prompt", "toggleterm"}}})
