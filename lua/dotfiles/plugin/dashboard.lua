-- [nfnl] Compiled from fnl/dotfiles/plugin/dashboard.fnl by https://github.com/Olical/nfnl, do not edit.
local _, dashboard = pcall(require, "dashboard")
return dashboard.setup({config = {shortcut = {{desc = "\239\158\178 Update", group = "@property", action = "Lazy update", key = "u"}, {desc = "\238\136\149 Files", group = "Label", action = "FzfLua files", key = "f"}}, project = {action = "FzfLua files cwd="}}})
