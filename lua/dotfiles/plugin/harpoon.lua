-- [nfnl] fnl/dotfiles/plugin/harpoon.fnl
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
do
  local opts_1_auto
  do
    local tbl_16_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_17_, v_18_ = k_2_auto, v_3_auto
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts_1_auto = tbl_16_
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
  local tbl_16_ = {}
  for k_2_auto, v_3_auto in pairs((nil or {})) do
    local k_17_, v_18_ = k_2_auto, v_3_auto
    if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
      tbl_16_[k_17_] = v_18_
    else
    end
  end
  opts_1_auto = tbl_16_
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
