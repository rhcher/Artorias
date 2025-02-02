-- [nfnl] Compiled from fnl/dotfiles/plugin/harpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
do
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_auto, v_18_auto = k_2_auto, v_3_auto
      if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
        tbl_16_auto[k_17_auto] = v_18_auto
      else
      end
    end
    opts_1_auto = tbl_16_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  local function _4_()
    return ui.toggle_quick_menu()
  end
  vim.keymap.set("n", "<leader>uu", _4_, opts_1_auto)
end
local opts_1_auto
do
  local tbl_16_auto = {}
  for k_2_auto, v_3_auto in pairs((nil or {})) do
    local k_17_auto, v_18_auto = k_2_auto, v_3_auto
    if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
      tbl_16_auto[k_17_auto] = v_18_auto
    else
    end
  end
  opts_1_auto = tbl_16_auto
end
if (opts_1_auto.noremap == nil) then
  opts_1_auto.noremap = true
else
end
if (opts_1_auto.silent == nil) then
  opts_1_auto.silent = true
else
end
local function _8_()
  return mark.add_file()
end
return vim.keymap.set("n", "<leader>ua", _8_, opts_1_auto)
