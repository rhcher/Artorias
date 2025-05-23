-- [nfnl] fnl/dotfiles/plugin/hlslens.fnl
local hlslens = require("hlslens")
hlslens.setup()
do
  local start_str = "<Cmd>lua require('hlslens').start()<CR>"
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
    vim.keymap.set("n", "n", ("<Cmd>execute('normal! ' . v:count1 . 'n')<CR>" .. start_str), opts_1_auto)
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
    vim.keymap.set("n", "N", ("<Cmd>execute('normal! ' . v:count1 . 'N')<CR>" .. start_str), opts_1_auto)
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
    vim.keymap.set({"n", "x"}, "*", ("<Plug>(asterisk-z*)" .. start_str), opts_1_auto)
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
    vim.keymap.set({"n", "x"}, "#", ("<Plug>(asterisk-z#)" .. start_str), opts_1_auto)
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
    vim.keymap.set({"n", "x"}, "g*", ("<Plug>(asterisk-gz*)" .. start_str), opts_1_auto)
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
  vim.keymap.set({"n", "x"}, "g#", ("<Plug>(asterisk-gz*)" .. start_str), opts_1_auto)
end
local group = vim.api.nvim_create_augroup("VMlens", {clear = true})
local function _19_()
  return require("dotfiles.plugin.vmlens").start
end
vim.api.nvim_create_autocmd({"User"}, {pattern = "visual_multi_start", callback = _19_, group = group})
local function _20_()
  return require("dotfiles.plugin.vmlens").exit
end
vim.api.nvim_create_autocmd({"User"}, {pattern = "visual_multi_exit", callback = _20_, group = group})
return nil
