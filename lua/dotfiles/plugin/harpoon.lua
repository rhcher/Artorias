-- [nfnl] Compiled from fnl/dotfiles/plugin/harpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
local term = require("harpoon.term")
local cmd = require("harpoon.cmd-ui")
do
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_15_auto, v_16_auto = k_2_auto, v_3_auto
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    opts_1_auto = tbl_14_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  vim.keymap.set("n", "<leader>uu", ui.toggle_quick_menu, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_15_auto, v_16_auto = k_2_auto, v_3_auto
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    opts_1_auto = tbl_14_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  vim.keymap.set("n", "<leader>ua", mark.add_file, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_15_auto, v_16_auto = k_2_auto, v_3_auto
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    opts_1_auto = tbl_14_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  vim.keymap.set("n", "<leader>un", ui.nav_next, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs((nil or {})) do
      local k_15_auto, v_16_auto = k_2_auto, v_3_auto
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    opts_1_auto = tbl_14_auto
  end
  if (opts_1_auto.noremap == nil) then
    opts_1_auto.noremap = true
  else
  end
  if (opts_1_auto.silent == nil) then
    opts_1_auto.silent = true
  else
  end
  vim.keymap.set("n", "<leader>up", ui.nav_prev, opts_1_auto)
end
local opts_1_auto
do
  local tbl_14_auto = {}
  for k_2_auto, v_3_auto in pairs((nil or {})) do
    local k_15_auto, v_16_auto = k_2_auto, v_3_auto
    if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
      tbl_14_auto[k_15_auto] = v_16_auto
    else
    end
  end
  opts_1_auto = tbl_14_auto
end
if (opts_1_auto.noremap == nil) then
  opts_1_auto.noremap = true
else
end
if (opts_1_auto.silent == nil) then
  opts_1_auto.silent = true
else
end
return vim.keymap.set("n", "<leader>tc", cmd.toggle_quick_menu, opts_1_auto)
