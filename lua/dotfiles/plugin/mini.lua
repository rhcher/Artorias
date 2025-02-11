-- [nfnl] Compiled from fnl/dotfiles/plugin/mini.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local _, mini_file = pcall(require, "mini.files")
  mini_file.setup()
end
do
  local _, mini_icon = pcall(require, "mini.icons")
  mini_icon.setup()
end
local _, mini_sessions = pcall(require, "mini.sessions")
return mini_sessions.setup()
