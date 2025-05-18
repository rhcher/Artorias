-- [nfnl] fnl/dotfiles/plugin/indent.fnl
local indent = require("ibl")
return indent.setup({scope = {show_end = false, show_start = false}, exclude = {filetypes = {"", "help", "fennel", "packer", "lspinfo", "tsplayground", "query", "scheme", "racket", "qf", "dashboard", "markdown"}, buftypes = {"terminal", "prompt", "toggleterm"}}})
