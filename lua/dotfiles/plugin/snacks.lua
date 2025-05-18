-- [nfnl] fnl/dotfiles/plugin/snacks.fnl
do
  local _, snacks = pcall(require, "snacks")
  snacks.setup({indent = {animate = {style = "down"}}, picker = {layout = {preset = "ivy", cycle = false}}, terminal = {}, styles = {}, images = {}, quickfile = {}, notifier = {}})
end
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
    return Snacks.picker.files()
  end
  vim.keymap.set("n", "<leader>ff", _4_, opts_1_auto)
end
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
  local function _8_()
    return Snacks.picker.files({cwd = "~/.config/nvim"})
  end
  vim.keymap.set("n", "<leader>fc", _8_, opts_1_auto)
end
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
  local function _12_()
    return Snacks.picker.grep()
  end
  vim.keymap.set("n", "<leader>fs", _12_, opts_1_auto)
end
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
  local function _16_()
    return Snacks.picker.buffers()
  end
  vim.keymap.set("n", "<leader>fb", _16_, opts_1_auto)
end
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
  local function _20_()
    return Snacks.picker.buffers()
  end
  vim.keymap.set("n", "<leader>bb", _20_, opts_1_auto)
end
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
  local function _24_()
    return Snacks.picker.help()
  end
  vim.keymap.set("n", "<leader>fh", _24_, opts_1_auto)
end
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
  local function _28_()
    return Snacks.picker.keymaps()
  end
  vim.keymap.set("n", "<leader>fk", _28_, opts_1_auto)
end
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
  local function _32_()
    return Snacks.picker.lines()
  end
  vim.keymap.set("n", "<leader>fl", _32_, opts_1_auto)
end
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
  local function _36_()
    return Snacks.picker.projects()
  end
  vim.keymap.set("n", "<leader>fp", _36_, opts_1_auto)
end
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
  local function _40_()
    return Snacks.picker.smart()
  end
  vim.keymap.set("n", "<leader>ss", _40_, opts_1_auto)
end
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
  local function _44_()
    return Snacks.picker.undo()
  end
  vim.keymap.set("n", "<leader>su", _44_, opts_1_auto)
end
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
  local function _48_()
    return Snacks.picker.highlights()
  end
  vim.keymap.set("n", "<leader>sh", _48_, opts_1_auto)
end
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
  local function _52_()
    return Snacks.notifier.show_history()
  end
  vim.keymap.set("n", "<leader>nf", _52_, opts_1_auto)
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
local function _56_()
  return Snacks.terminal()
end
return vim.keymap.set("n", "<leader>ot", _56_, opts_1_auto)
