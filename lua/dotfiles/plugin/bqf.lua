-- [nfnl] fnl/dotfiles/plugin/bqf.fnl
local _, bqf = pcall(require, "bqf")
return bqf.setup({preview = {border = {" ", "\226\148\129", " ", " ", " ", "\226\148\129", " ", " "}, winblend = 0, auto_preview = false}, auto_resize_height = true})
