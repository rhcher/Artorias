-- [nfnl] Compiled from fnl/dotfiles/plugin/mini.fnl by https://github.com/Olical/nfnl, do not edit.
local _, mini_file = pcall(require, "mini.files")
local _0, mini_icon = pcall(require, "mini.icons")
local _1, mini_sessions = pcall(require, "mini.sessions")
local _2, mini_snippet = pcall(require, "mini.snippets")
mini_file.setup()
mini_icon.setup()
mini_sessions.setup()
return mini_snippet.setup()
