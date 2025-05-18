-- [nfnl] fnl/dotfiles/plugin/lspsaga.fnl
local _, lspsaga = pcall(require, "lspsaga")
return lspsaga.setup({lightbulb = {sign_priority = 99, virtual_text = false}, symbol_in_winbar = {enable = true}, finder = {layout = "normal"}, diagnostic = {on_insert = false}, hover = {open_link = "gf"}, outline = {keys = {jump = "<CR>", expand_collapse = "o"}, auto_preview = false}, ui = {border = {"", "\226\148\129", "", "", "", "\226\148\129", "", ""}}})
