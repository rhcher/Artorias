-- [nfnl] fnl/plugins/ui.fnl
local function _1_()
  return vim.cmd.colorscheme("srcery")
end
local function _2_()
  return vim.cmd.colorscheme("paper")
end
local function _3_()
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
  local function _10_(bufnr, filetype, buftype)
    return ftmap[filetype]
  end
  return ufo.setup({provider_selector = _10_})
end
local function _11_()
  local builtin = require("statuscol.builtin")
  local statuscol = require("statuscol")
  return statuscol.setup({relculright = true, segments = {{text = {"%s"}, click = "v:lua.ScSa"}, {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}, {text = {builtin.foldfunc}, click = "v:lua.ScFa"}}})
end
local function _12_()
  return require("config.qftf")
end
return {{"nvim-lualine/lualine.nvim", config = true, lazy = false}, {"rhcher/srcery.nvim", config = _1_, lazy = false, priority = 1000}, {"rhcher/vim-paper", cond = false, config = _2_, lazy = false, priority = 1000}, {"kevinhwang91/nvim-ufo", config = _3_, dependencies = {{"kevinhwang91/promise-async", {"luukvbaal/statuscol.nvim", config = _11_}}}, event = "VeryLazy"}, {"kevinhwang91/nvim-bqf", ft = "qf", init = _12_, opts = {preview = {border = {" ", "\226\148\129", " ", " ", " ", "\226\148\129", " ", " "}, winblend = 0, auto_preview = false}, auto_resize_height = true}}, {"utilyre/sentiment.nvim", event = "VeryLazy", opts = {}, version = false}}
