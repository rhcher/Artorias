-- [nfnl] fnl/plugins/git.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local gitsigns = autoload("gitsigns")
local on_attach
local function _2_(bufnr)
  local gs = package.loaded.gitsigns
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs(({expr = true} or {})) do
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
    local function _6_()
      if vim.wo.diff then
        return "]c"
      else
        local function _7_()
          return gs.next_hunk()
        end
        vim.schedule(_7_)
        return "<Ignore>"
      end
    end
    vim.keymap.set("n", "]c", _6_, opts_3_auto)
  end
  do
    local opts_3_auto
    do
      local tbl_21_ = {}
      for k_4_auto, v_5_auto in pairs(({expr = true} or {})) do
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
    local function _12_()
      if vim.wo.diff then
        return "[c"
      else
        local function _13_()
          return gs.prev_hunk()
        end
        vim.schedule(_13_)
        return "<Ignore>"
      end
    end
    vim.keymap.set("n", "[c", _12_, opts_3_auto)
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
    vim.keymap.set({"n", "v"}, "<leader>hs", gs.stage_hunk, opts_3_auto)
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
    vim.keymap.set({"n", "v"}, "<leader>hr", gs.reset_hunk, opts_3_auto)
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
    vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts_3_auto)
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
    vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts_3_auto)
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
    vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts_3_auto)
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
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts_3_auto)
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
    local function _36_()
      return gs.blame_line({full = true})
    end
    vim.keymap.set("n", "<leader>hb", _36_, opts_3_auto)
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
    vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, opts_3_auto)
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
    vim.keymap.set("n", "<leader>hd", gs.diffthis, opts_3_auto)
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
    local function _46_()
      return gs.diffthis("~")
    end
    vim.keymap.set("n", "<leader>hD", _46_, opts_3_auto)
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
    vim.keymap.set("n", "<leader>td", gs.toggle_deleted, opts_3_auto)
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
  return vim.keymap.set({"x", "o"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts_3_auto)
end
on_attach = _2_
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
  vim.keymap.set("n", "<leader>gg", ":Git<CR><C-w>o", opts_3_auto)
end
vim.g.nremap = {["[m"] = "[f", ["]m"] = "]f", ["="] = "<tab>"}
local function _56_()
  local codediff = require("codediff")
  do local _ = codediff.setup end
  return {highlights = {line_insert = "DiffAdd", line_delete = "DiffDelete", char_insert = "DiffText", char_delete = "DiffDelete", char_brightness = "DiffText"}}
end
return {{"tpope/vim-fugitive", cmd = "Git"}, {"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, opts = {sign_priority = 5, on_attach = on_attach, signs = {add = {text = "\226\148\130"}, change = {text = "\226\148\130"}, changedelete = {text = "~"}, delete = {text = "_"}, topdelete = {text = "\226\128\190"}}, status_formatter = nil, watch_gitdir = {interval = 100}}}, {"esmuellert/vscode-diff.nvim", branch = "next", cmd = "CodeDiff", config = _56_, dependencies = {"MunifTanjim/nui.nvim"}}, {"chrisgrieser/nvim-spider", keys = {{"w", "<cmd>lua require('spider').motion('w')<CR>", mode = {"n", "o", "x"}}, {"e", "<cmd>lua require('spider').motion('e')<CR>", mode = {"n", "o", "x"}}, {"b", "<cmd>lua require('spider').motion('b')<CR>", mode = {"n", "o", "x"}}, {"ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = {"n", "o", "x"}}}}}
