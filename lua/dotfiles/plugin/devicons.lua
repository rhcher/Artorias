-- [nfnl] fnl/dotfiles/plugin/devicons.fnl
local _, devicons = pcall(require, "nvim-web-devicons")
local fnl_custom = {icon = "\238\152\160", color = "#e6b439", cterm_color = "65", name = "fennel"}
local fnl_alt = {icon = "\238\136\175", color = "#7bc45c", name = "fennel"}
return devicons.set_icon({fnl = fnl_alt})
