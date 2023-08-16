-- [nfnl] Compiled from fnl/dotfiles/diagnostic.fnl by https://github.com/Olical/nfnl, do not edit.
vim.diagnostic.config({signs = true, float = {header = "", prefix = "", source = "if_many", border = "single", title = "Diagnostic:", title_pos = "left", focusable = false}, virtual_text = false, update_in_insert = false})
do
  local signs = {Error = "\239\153\153 ", Warn = "\239\148\169 ", Hint = "\239\160\181 ", Info = "\239\145\137 "}
  for type, icon in pairs(signs) do
    local hl = ("DiagnosticSign" .. type)
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
  end
end
do
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  local function _4_()
    return vim.diagnostic.open_float(0, {scope = "line", close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"}})
  end
  vim.keymap.set("n", "<space>le", _4_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  vim.keymap.set("n", "<space>lQ", vim.diagnostic.setqflist, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  vim.keymap.set("n", "<space>lq", vim.diagnostic.setloclist, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_14_auto = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts_1_auto)
end
local opts_1_auto
do
  local tbl_14_auto = {}
  for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
return vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts_1_auto)
