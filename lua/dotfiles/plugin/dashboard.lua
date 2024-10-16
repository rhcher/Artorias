-- [nfnl] Compiled from fnl/dotfiles/plugin/dashboard.fnl by https://github.com/Olical/nfnl, do not edit.
local _, dashboard = pcall(require, "dashboard")
return dashboard.setup({config = {shortcut = {{desc = "\239\158\178 Sync", group = "@property", action = "Lazy sync", key = "s"}, {desc = "\238\136\149 Files", group = "Label", action = "FzfLua files", key = "f"}}, project = {action = "FzfLua files cwd="}}, disable_move = true, preview = {command = "cat", file_path = (vim.fn.stdpath("config") .. "/neovim.cat"), file_height = 10, file_width = 70}})
