-- [nfnl] Compiled from fnl/dotfiles/plugin/indent.fnl by https://github.com/Olical/nfnl, do not edit.
local _, indent = pcall(require, "indent_blankline")
return indent.setup({use_treesitter = true, use_treesitter_scope = true, filetype_exclude = {"", "help", "fennel", "packer", "lspinfo", "tsplayground", "query", "scheme", "racket", "qf", "dashboard", "markdown", "c", "cpp"}, buftype_exclude = {"terminal", "prompt", "toggleterm"}, show_trailing_blankline_indent = false})
