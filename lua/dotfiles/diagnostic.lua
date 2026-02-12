-- [nfnl] fnl/dotfiles/diagnostic.fnl
vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\240\159\146\169", [vim.diagnostic.severity.WARN] = "\240\159\152\133", [vim.diagnostic.severity.HINT] = "\240\159\164\147", [vim.diagnostic.severity.INFO] = "\240\159\164\148"}}, float = {header = "", prefix = "", source = "if_many", border = "single", title = "Diagnostic:", title_pos = "left", focusable = false}, underline = false, virtual_lines = false, virtual_text = false})
do
  local opts_1_auto
  do
    local tbl_21_ = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
    return vim.diagnostic.open_float(0, {scope = "line", close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"}})
  end
  vim.keymap.set("n", "<space>le", _4_, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_21_ = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  vim.keymap.set("n", "<space>lQ", vim.diagnostic.setqflist, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_21_ = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  vim.keymap.set("n", "<space>lq", vim.diagnostic.setloclist, opts_1_auto)
end
do
  local opts_1_auto
  do
    local tbl_21_ = {}
    for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
  vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts_1_auto)
end
local opts_1_auto
do
  local tbl_21_ = {}
  for k_2_auto, v_3_auto in pairs(({noremap = true, silent = true} or {})) do
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
return vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts_1_auto)
