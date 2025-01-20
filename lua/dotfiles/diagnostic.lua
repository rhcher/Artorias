-- [nfnl] Compiled from fnl/dotfiles/diagnostic.fnl by https://github.com/Olical/nfnl, do not edit.
vim.diagnostic.config({virtual_text = true, signs = {text = {["vim.diagnostic.severity.ERROR"] = "\240\159\152\168", ["vim.diagnostic.severity.WARN"] = "\240\159\152\146", ["vim.diagnostic.severity.HINT"] = "\240\159\152\141", ["vim.diagnostic.severity.INFO"] = "\240\159\152\152"}}, float = {header = "", prefix = "", source = "if_many", border = "single", title = "Diagnostic:", title_pos = "left", focusable = false}})
do
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
    return vim.diagnostic.open_float(0, {scope = "line", close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"}})
  end
  vim.keymap.set("n", "<space>le", _4_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  vim.keymap.set("n", "<space>lQ", vim.diagnostic.setqflist, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  vim.keymap.set("n", "<space>lq", vim.diagnostic.setloclist, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_16_auto = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts_1_auto)
end
local opts_1_auto
do
  local tbl_16_auto = {}
  for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
return vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts_1_auto)
