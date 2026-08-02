-- [nfnl] fnl/plugins/ui.fnl
local config = nil
local lens_bak = nil
local function override_lens(render, pos_list, nearest, idx, rel_idx)
  local _ = rel_idx
  local lnum, col = unpack(pos_list[idx])
  local text, chunks = nil
  if nearest then
    text = ("[%d/%d]"):format(idx, #pos_list)
    chunks = {{" ", "Ignore"}, {text, "VM_Extend"}}
  else
    text = ("[%d]"):format(idx)
    chunks = {{" ", "Ignore"}, {text, "HlSearchLens"}}
  end
  return render.setVirt(0, (lnum - 1), (col - 1), chunks, nearest)
end
local function start()
  local hlslens = require("hlslens")
  if hlslens then
    config = require("hlslens.config")
    lens_bak = config.override_lens
    config.override_lens = override_lens
    return hlslens.start()
  else
    return nil
  end
end
local function exit()
  local hlslens = require("hlslens")
  if hlslens then
    config.override_lens = lens_bak
    return hlslens.start()
  else
    return nil
  end
end
do
  local group = vim.api.nvim_create_augroup("VMlens", {clear = true})
  local function _4_()
    return start()
  end
  vim.api.nvim_create_autocmd({"User"}, {pattern = "visual_multi_start", callback = _4_, group = group})
  local function _5_()
    return exit()
  end
  vim.api.nvim_create_autocmd({"User"}, {pattern = "visual_multi_exit", callback = _5_, group = group})
end
local function _6_()
  return vim.cmd.colorscheme("srcery")
end
local function _7_()
  return vim.cmd.colorscheme("paper")
end
local function _8_()
  local ufo = require("ufo")
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs((nil or {})) do
        local k_22_, v_23_ = k_4_auto, v_5_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_3_auto = tbl_21_
    end
    if (opts_3_auto.noremap == nil) then
      opts_3_auto.noremap = true
    else
    end
    if (opts_3_auto.silent == nil) then
      opts_3_auto.silent = true
    else
    end
    vim.keymap.set("n", "zR", ufo.openAllFolds, opts_3_auto)
  end
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs((nil or {})) do
        local k_22_, v_23_ = k_4_auto, v_5_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_3_auto = tbl_21_
    end
    if (opts_3_auto.noremap == nil) then
      opts_3_auto.noremap = true
    else
    end
    if (opts_3_auto.silent == nil) then
      opts_3_auto.silent = true
    else
    end
    vim.keymap.set("n", "zM", ufo.closeAllFolds, opts_3_auto)
  end
  local ftmap = {vim = "indent", fennel = "treesitter", python = "indent", git = "", sagaoutline = "", sagafinder = ""}
  local function _15_(bufnr, filetype, buftype)
    return ftmap[filetype]
  end
  return ufo.setup({provider_selector = _15_})
end
local function _16_()
  local builtin = require("statuscol.builtin")
  local statuscol = require("statuscol")
  return statuscol.setup({relculright = true, segments = {{text = {"%s"}, click = "v:lua.ScSa"}, {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}, {text = {builtin.foldfunc}, click = "v:lua.ScFa"}}})
end
local function _17_()
  return require("config.qftf")
end
local function _18_()
  local start_str = "<Cmd>lua require('hlslens').start()<CR>"
  local hlslens = require("hlslens")
  hlslens.setup()
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs((nil or {})) do
        local k_22_, v_23_ = k_4_auto, v_5_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_3_auto = tbl_21_
    end
    if (opts_3_auto.noremap == nil) then
      opts_3_auto.noremap = true
    else
    end
    if (opts_3_auto.silent == nil) then
      opts_3_auto.silent = true
    else
    end
    vim.keymap.set("n", "n", ("<Cmd>execute('normal! ' . v:count1 . 'n')<CR>" .. start_str), opts_3_auto)
  end
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs((nil or {})) do
        local k_22_, v_23_ = k_4_auto, v_5_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_3_auto = tbl_21_
    end
    if (opts_3_auto.noremap == nil) then
      opts_3_auto.noremap = true
    else
    end
    if (opts_3_auto.silent == nil) then
      opts_3_auto.silent = true
    else
    end
    vim.keymap.set("n", "N", ("<Cmd>execute('normal! ' . v:count1 . 'N')<CR>" .. start_str), opts_3_auto)
  end
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs((nil or {})) do
        local k_22_, v_23_ = k_4_auto, v_5_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_3_auto = tbl_21_
    end
    if (opts_3_auto.noremap == nil) then
      opts_3_auto.noremap = true
    else
    end
    if (opts_3_auto.silent == nil) then
      opts_3_auto.silent = true
    else
    end
    vim.keymap.set({"n", "x"}, "*", ("<Plug>(asterisk-z*)" .. start_str), opts_3_auto)
  end
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs((nil or {})) do
        local k_22_, v_23_ = k_4_auto, v_5_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_3_auto = tbl_21_
    end
    if (opts_3_auto.noremap == nil) then
      opts_3_auto.noremap = true
    else
    end
    if (opts_3_auto.silent == nil) then
      opts_3_auto.silent = true
    else
    end
    vim.keymap.set({"n", "x"}, "#", ("<Plug>(asterisk-z#)" .. start_str), opts_3_auto)
  end
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs((nil or {})) do
        local k_22_, v_23_ = k_4_auto, v_5_auto
        if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
          tbl_21_[k_22_] = v_23_
        else
        end
      end
      opts_3_auto = tbl_21_
    end
    if (opts_3_auto.noremap == nil) then
      opts_3_auto.noremap = true
    else
    end
    if (opts_3_auto.silent == nil) then
      opts_3_auto.silent = true
    else
    end
    vim.keymap.set({"n", "x"}, "g*", ("<Plug>(asterisk-gz*)" .. start_str), opts_3_auto)
  end
  local opts_3_auto
  do
    local tbl_21_ = {}
    for k_4_auto, v_5_auto in pairs((nil or {})) do
      local k_22_, v_23_ = k_4_auto, v_5_auto
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    opts_3_auto = tbl_21_
  end
  if (opts_3_auto.noremap == nil) then
    opts_3_auto.noremap = true
  else
  end
  if (opts_3_auto.silent == nil) then
    opts_3_auto.silent = true
  else
  end
  return vim.keymap.set({"n", "x"}, "g#", ("<Plug>(asterisk-gz*)" .. start_str), opts_3_auto)
end
return {{"nvim-lualine/lualine.nvim", config = true, lazy = false}, {"rhcher/srcery.nvim", config = _6_, lazy = false, priority = 1000}, {"rhcher/vim-paper", cond = false, config = _7_, lazy = false, priority = 1000}, {"kevinhwang91/nvim-ufo", config = _8_, dependencies = {{"kevinhwang91/promise-async"}, {"luukvbaal/statuscol.nvim", config = _16_}}, event = "VeryLazy"}, {"kevinhwang91/nvim-bqf", ft = "qf", init = _17_, opts = {preview = {border = {" ", "\226\148\129", " ", " ", " ", "\226\148\129", " ", " "}, winblend = 0, auto_preview = false}, auto_resize_height = true}}, {"kevinhwang91/nvim-hlslens", config = _18_, dependencies = {"haya14busa/vim-asterisk"}, event = "VeryLazy"}, {"utilyre/sentiment.nvim", event = "VeryLazy", opts = {}, version = false}}
