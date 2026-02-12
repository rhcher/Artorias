-- [nfnl] fnl/dotfiles/plugin/harpoon.fnl
local harpoon = require("harpoon")
harpoon:setup()
do
  local opts_1_auto
  do
    local tbl_21_ = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_22_, v_23_ = k_2_auto, v_3_auto
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    opts_1_auto = tbl_21_
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
    return harpoon:list():add()
  end
  vim.keymap.set("n", "<leader>ua", _4_, opts_1_auto)
end
local opts_1_auto
do
  local tbl_21_ = {}
  for k_2_auto, v_3_auto in pairs((nil or {})) do
    local k_22_, v_23_ = k_2_auto, v_3_auto
    if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
      tbl_21_[k_22_] = v_23_
    else
    end
  end
  opts_1_auto = tbl_21_
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
  return harpoon.ui:toggle_quick_menu(harpoon:list())
end
return vim.keymap.set("n", "<leader>uu", _8_, opts_1_auto)
